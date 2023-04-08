
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

    # generate transactions
    random.seed(0)
    trans = []
    ram = [0] * depth
    for i in range(depth):
        ram[i] = random.randint(0, (1 << width) - 1)
        trans.append(("w", i, ram[i]))
    for i in range(1000):
        addr = random.randint(0, depth-1)
        data = random.randint(0, (1 << width) - 1)
        rand = random.randint(0, 9)
        if rand <= 3:
            # read
            trans.append(("r", addr, ram[addr]))
        elif rand < 9:
            if ports == {"read", "write"} and rand < 6:
                # read+write
                # write first
                ram[addr] = data
                raddr = random.randint(0, depth-1)
                trans.append(("rw", addr, data, raddr, ram[raddr]))
            else:
                # write
                ram[addr] = data
                trans.append(("w", addr, data))
        else:
            # bubble
            trans.append(("b"))

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
        # behavior
        print(f'  reg [{width-1}:0] ram [{depth-1}:0];', file=f)
        print(f'  reg [{addr_width-1}:0] reg_RW0_addr;', file=f)
        print(f'  wire [{width-1}:0] RW0_rdata_behav;', file=f)

        print(f'  initial begin', file=f)
        print(f'    RW0_clk = 1;', file=f)
        print(f'    RW0_en = 0;', file=f)
        print(f'    RW0_wmode = 0;', file=f)
        print(f'    RW0_addr = 0;', file=f)
        print(f'    RW0_wdata = 0;', file=f)
        print(f'    #1;', file=f)
        print(f'    #10;', file=f)
        for tx in trans:
            if tx[0] == "w":
                print(f'    RW0_en = 1;', file=f)
                print(f'    RW0_wmode = 1;', file=f)
                print(f'    RW0_addr = {tx[1]};', file=f)
                print(f'    RW0_wdata = \'h{tx[2]:x};', file=f)
                print(f'    #10;', file=f)
            elif tx[0] == "r":
                print(f'    RW0_en = 1;', file=f)
                print(f'    RW0_wmode = 0;', file=f)
                print(f'    RW0_addr = {tx[1]};', file=f)
                print(f'    #10;', file=f)
                print(
                    f'    if (RW0_rdata != \'h{tx[2]:x} || RW0_rdata != RW0_rdata_behav) begin', file=f)
                print(f'      $display("ASSERTION FAILED");', file=f)
                print(f'      $finish;', file=f)
                print(f'    end', file=f)
            elif tx[0] == "b":
                print(f'    RW0_en = 0;', file=f)
                print(f'    #10;', file=f)

        print(f'    $finish;', file=f)
        print(f'  end', file=f)

        print(f'  always #5 RW0_clk = ~RW0_clk;', file=f)

        # behavior, write first
        print(f'  always @ (posedge RW0_clk) begin', file=f)
        print(f'    if (RW0_en && !RW0_wmode) begin', file=f)
        print(f'      reg_RW0_addr <= RW0_addr;', file=f)
        print(f'    end', file=f)
        print(f'    if (RW0_en && RW0_wmode) begin', file=f)
        print(f'      ram[RW0_addr] <= RW0_wdata;', file=f)
        print(f'    end', file=f)
        print(f'  end', file=f)
        print(f'  assign RW0_rdata_behav = ram[reg_RW0_addr];', file=f)

        print(f'  {config.name} inst (', file=f)
        print(f'    .RW0_addr(RW0_addr),', file=f)
        print(f'    .RW0_en(RW0_en),', file=f)
        print(f'    .RW0_clk(RW0_clk),', file=f)
        print(f'    .RW0_wmode(RW0_wmode),', file=f)
        print(f'    .RW0_wdata(RW0_wdata),', file=f)
        print(f'    .RW0_rdata(RW0_rdata)', file=f)
        print(f'  );', file=f)
    elif ports == {"read", "write"}:
        # 1R1W
        print(f'  reg [{addr_width-1}:0] R0_addr;', file=f)
        print(f'  reg R0_en;', file=f)
        print(f'  reg R0_clk;', file=f)
        print(f'  wire [{width-1}:0] R0_data;', file=f)
        print(f'  reg [{addr_width-1}:0] W0_addr;', file=f)
        print(f'  reg W0_en;', file=f)
        print(f'  reg W0_clk;', file=f)
        print(f'  reg [{width-1}:0] W0_data;', file=f)
        # behavior
        print(f'  reg [{width-1}:0] ram [{depth-1}:0];', file=f)
        print(f'  reg [{addr_width-1}:0] reg_R0_addr;', file=f)
        print(f'  wire [{width-1}:0] R0_data_behav;', file=f)

        print(f'  initial begin', file=f)
        print(f'    R0_clk = 1;', file=f)
        print(f'    R0_en = 0;', file=f)
        print(f'    R0_addr = 0;', file=f)
        print(f'    W0_clk = 1;', file=f)
        print(f'    W0_en = 0;', file=f)
        print(f'    W0_addr = 0;', file=f)
        print(f'    W0_data = 0;', file=f)
        print(f'    #1;', file=f)
        for tx in trans:
            if tx[0] == "w":
                print(f'    R0_en = 0;', file=f)
                print(f'    W0_en = 1;', file=f)
                print(f'    W0_addr = {tx[1]};', file=f)
                print(f'    W0_data = \'h{tx[2]:x};', file=f)
                print(f'    #10;', file=f)
            elif tx[0] == "r":
                print(f'    R0_en = 1;', file=f)
                print(f'    W0_en = 0;', file=f)
                print(f'    R0_addr = {tx[1]};', file=f)
                print(f'    #10;', file=f)
                print(
                    f'    if (R0_data != \'h{tx[2]:x} || R0_data != R0_data_behav) begin', file=f)
                print(f'      $display("ASSERTION FAILED");', file=f)
                print(f'      $finish;', file=f)
                print(f'    end', file=f)
            elif tx[0] == "rw":
                print(f'    R0_en = 1;', file=f)
                print(f'    R0_addr = {tx[3]};', file=f)
                print(f'    W0_en = 1;', file=f)
                print(f'    W0_addr = {tx[1]};', file=f)
                print(f'    W0_data = \'h{tx[2]:x};', file=f)
                print(f'    #10;', file=f)
                print(
                    f'    if (R0_data != \'h{tx[4]:x} || R0_data != R0_data_behav) begin', file=f)
                print(f'      $display("ASSERTION FAILED");', file=f)
                print(f'      $finish;', file=f)
                print(f'    end', file=f)
            else:
                print(f'    R0_en = 0;', file=f)
                print(f'    W0_en = 0;', file=f)
                print(f'    #10;', file=f)

        print(f'    $finish;', file=f)
        print(f'  end', file=f)

        print(f'  always #5 R0_clk = ~R0_clk;', file=f)
        print(f'  always #5 W0_clk = ~W0_clk;', file=f)

        # behavior, write first
        print(f'  always @ (posedge R0_clk) begin', file=f)
        print(f'    if (R0_en) begin', file=f)
        print(f'      reg_R0_addr <= R0_addr;', file=f)
        print(f'    end', file=f)
        print(f'  end', file=f)
        print(f'  always @ (posedge W0_clk) begin', file=f)
        print(f'    if (W0_en) begin', file=f)
        print(f'      ram[W0_addr] <= W0_data;', file=f)
        print(f'    end', file=f)
        print(f'  end', file=f)
        print(f'  assign R0_data_behav = ram[reg_R0_addr];', file=f)

        print(f'  {config.name} inst (', file=f)
        print(f'    .R0_addr(R0_addr),', file=f)
        print(f'    .R0_en(R0_en),', file=f)
        print(f'    .R0_clk(R0_clk),', file=f)
        print(f'    .R0_data(R0_data),', file=f)
        print(f'    .W0_addr(W0_addr),', file=f)
        print(f'    .W0_en(W0_en),', file=f)
        print(f'    .W0_clk(W0_clk),', file=f)
        print(f'    .W0_data(W0_data)', file=f)
        print(f'  );', file=f)
    print(f'endmodule', file=f)
    return f.getvalue()
