
from io import StringIO
import os
import random
from chisel_memory_lower.parser import Config


def generate_header(config: Config, target: str) -> str:
    f = StringIO()
    ports = set(config.ports.split(','))
    depth = int(config.depth)
    width = int(config.width)
    addr_width = (depth-1).bit_length()
    print(f'// Generate by chisel-memory-lower', file=f)
    print(f'// Target: {target}', file=f)
    print(f'// {config}', file=f)
    print(f'`timescale 1ns/1ps', file=f)
    print(f'module {config.name} (', file=f)
    if ports == {"rw"}:
        # 1RW
        print(f'  input [{addr_width-1}:0] RW0_addr,', file=f)
        print(f'  input RW0_en,', file=f)
        print(f'  input RW0_clk,', file=f)
        print(f'  input RW0_wmode,', file=f)
        print(f'  input [{width-1}:0] RW0_wdata,', file=f)
        print(f'  output [{width-1}:0] RW0_rdata', file=f)
    elif ports == {"read", "write"}:
        # 1RW
        print(f'  input [{addr_width-1}:0] R0_addr,', file=f)
        print(f'  input R0_en,', file=f)
        print(f'  input R0_clk,', file=f)
        print(f'  output [{width-1}:0] R0_data,', file=f)
        print(f'  input [{addr_width-1}:0] W0_addr,', file=f)
        print(f'  input W0_en,', file=f)
        print(f'  input W0_clk,', file=f)
        print(f'  input [{width-1}:0] W0_data', file=f)
    elif ports == {"read", "mwrite"}:
        # 1RW Masked
        mask_gran = int(config.mask_gran)
        print(f'  input [{addr_width-1}:0] R0_addr,', file=f)
        print(f'  input R0_en,', file=f)
        print(f'  input R0_clk,', file=f)
        print(f'  output [{width-1}:0] R0_data,', file=f)
        print(f'  input [{addr_width-1}:0] W0_addr,', file=f)
        print(f'  input W0_en,', file=f)
        print(f'  input W0_clk,', file=f)
        print(f'  input [{width-1}:0] W0_data,', file=f)
        print(f'  input [{width//mask_gran-1}:0] W0_mask', file=f)

    print(f');', file=f)
    return f.getvalue()


def generate_tb(config: Config) -> str:
    f = StringIO()
    ports = set(config.ports.split(','))
    depth = int(config.depth)
    width = int(config.width)
    addr_width = (depth-1).bit_length()

    vivado_version = '2020.2'
    with open(f'{config.name}_xilinx.prj', 'w') as file:
        print(f'verilog work {config.name}_xilinx.v', file=file)
        print(f'verilog work {config.name}_xilinx_tb.v', file=file)
        print(
            f'sv work /opt/Xilinx/Vivado/{vivado_version}/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv', file=file)

    with open(f'{config.name}_xilinx.sh', 'w') as file:
        print(f'#!/bin/bash', file=file)
        print(
            f'export PATH=/opt/Xilinx/Vivado/{vivado_version}/bin:$PATH', file=file)
        print(
            f'xelab -debug all {config.name}_tb -prj {config.name}_xilinx.prj', file=file)
        print(f'xsim {config.name}_tb --tclbatch sim.tcl', file=file)
    os.chmod(f'{config.name}_xilinx.sh', 0o755)

    # generate transactions
    random.seed(0)
    trans = []
    ram = [0] * depth
    for i in range(depth):
        ram[i] = random.randint(0, (1 << width) - 1)
        trans.append(("w", i, ram[i]))
    for i in range(100):
        addr = random.randint(0, depth-1)
        data = random.randint(0, (1 << width) - 1)
        if random.randint(0, 1) == 0:
            trans.append(("r", addr, ram[addr]))
        else:
            ram[addr] = data
            trans.append(("w", addr, data))

    print(f'`timescale 1ns/1ps', file=f)
    print(f'module {config.name}_tb (', file=f)
    print(f');', file=f)
    if ports == {"rw"}:
        # 1RW
        print(f'  reg [{addr_width-1}:0] RW0_addr;', file=f)
        print(f'  reg RW0_en;', file=f)
        print(f'  reg RW0_clk;', file=f)
        print(f'  reg RW0_wmode;', file=f)
        print(f'  reg [{width-1}:0] RW0_wdata;', file=f)
        print(f'  wire [{width-1}:0] RW0_rdata;', file=f)

        print(f'  initial begin', file=f)
        print(f'    RW0_clk = 1;', file=f)
        print(f'    RW0_en = 0;', file=f)
        print(f'    RW0_wmode = 0;', file=f)
        print(f'    RW0_addr = 0;', file=f)
        print(f'    RW0_wdata = 0;', file=f)
        print(f'    #1;', file=f)
        for tx in trans:
            print(f'    #10;', file=f)
            if tx[0] == "w":
                print(f'    RW0_en = 1;', file=f)
                print(f'    RW0_wmode = 1;', file=f)
                print(f'    RW0_addr = {tx[1]};', file=f)
                print(f'    RW0_wdata = \'h{tx[2]:x};', file=f)
                print(f'    #10;', file=f)
                print(f'    RW0_en = 0;', file=f)
            else:
                print(f'    RW0_en = 1;', file=f)
                print(f'    RW0_wmode = 0;', file=f)
                print(f'    RW0_addr = {tx[1]};', file=f)
                print(f'    #10;', file=f)
                print(f'    RW0_en = 0;', file=f)
                print(f'    if (RW0_rdata != \'h{tx[2]:x}) begin', file=f)
                print(f'      $display("ASSERTION FAILED");', file=f)
                print(f'      $finish;', file=f)
                print(f'    end', file=f)

        print(f'    $finish;', file=f)
        print(f'  end', file=f)

        print(f'  always #5 RW0_clk = ~RW0_clk;', file=f)

        print(f'  {config.name} inst (', file=f)
        print(f'    .RW0_addr(RW0_addr),', file=f)
        print(f'    .RW0_en(RW0_en),', file=f)
        print(f'    .RW0_clk(RW0_clk),', file=f)
        print(f'    .RW0_wmode(RW0_wmode),', file=f)
        print(f'    .RW0_wdata(RW0_wdata),', file=f)
        print(f'    .RW0_rdata(RW0_rdata)', file=f)
        print(f'  );', file=f)
    print(f'endmodule', file=f)
    return f.getvalue()
