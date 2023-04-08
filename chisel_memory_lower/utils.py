
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
    mask_gran = config.mask_gran
    addr_width = (depth-1).bit_length()

    # generate transactions
    random.seed(0)
    trans = []
    ram = [0] * depth
    for i in range(depth):
        ram[i] = random.randint(0, (1 << width) - 1)
        if "mwrite" in ports:
            mask_gran = int(mask_gran)
            mask_bits = width // mask_gran
            wmask = (1 << mask_bits) - 1
            trans.append(("w", i, ram[i], wmask))
        else:
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
                # allow x/read_first/write_first
                if rand == 5:
                    # test read-write collision
                    raddr = addr
                else:
                    raddr = random.randint(0, depth-1)
                if raddr == addr:
                    old = ram[addr]
                    ram[addr] = data
                    trans.append(("rw", addr, data, raddr, old, data))
                else:
                    ram[addr] = data
                    trans.append(("rw", addr, data, raddr, ram[raddr]))
            else:
                # write
                if "mwrite" in ports:
                    # masked write
                    mask_gran = int(mask_gran)
                    mask_bits = width // mask_gran
                    wmask = random.randint(0, (1 << mask_bits) - 1)
                    bmask = 0
                    for j in range(mask_bits):
                        if wmask & (1 << j) != 0:
                            bmask |= ((1 << mask_gran) - 1) << (mask_gran * j)
                    ram[addr] = (ram[addr] & ~bmask) | (data & bmask)
                    trans.append(("w", addr, data, wmask))
                else:
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

        print(f'  initial begin', file=f)
        print(f'    RW0_clk = 1;', file=f)
        print(f'    RW0_en = 0;', file=f)
        print(f'    RW0_wmode = 0;', file=f)
        print(f'    RW0_addr = 0;', file=f)
        print(f'    RW0_wdata = 0;', file=f)
        print(f'    #2;', file=f)
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
                    f'    if (RW0_rdata !== \'h{tx[2]:x}) begin', file=f)
                print(f'      $display("ASSERTION FAILED");', file=f)
                print(f'      $finish;', file=f)
                print(f'    end', file=f)
            elif tx[0] == "b":
                print(f'    RW0_en = 0;', file=f)
                print(f'    #10;', file=f)

        print(f'    $display("SIMULATION SUCCESS");', file=f)
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
    elif ports == {"read", "write"} or ports == {"read", "mwrite"}:
        # 1R1W or 1R1W masked
        print(f'  reg [{addr_width-1}:0] R0_addr;', file=f)
        print(f'  reg R0_en;', file=f)
        print(f'  reg R0_clk;', file=f)
        print(f'  wire [{width-1}:0] R0_data;', file=f)
        print(f'  reg [{addr_width-1}:0] W0_addr;', file=f)
        print(f'  reg W0_en;', file=f)
        print(f'  reg W0_clk;', file=f)
        print(f'  reg [{width-1}:0] W0_data;', file=f)
        if "mwrite" in ports:
            print(f'  reg [{width//int(mask_gran)-1}:0] W0_mask;', file=f)

        print(f'  initial begin', file=f)
        print(f'    R0_clk = 1;', file=f)
        print(f'    R0_en = 0;', file=f)
        print(f'    R0_addr = 0;', file=f)
        print(f'    W0_clk = 1;', file=f)
        print(f'    W0_en = 0;', file=f)
        print(f'    W0_addr = 0;', file=f)
        print(f'    W0_data = 0;', file=f)
        if "mwrite" in ports:
            print(
                f'    W0_mask = {{{width//int(mask_gran)}{{1\'b1}}}};', file=f)
        print(f'    #2;', file=f)
        for tx in trans:
            if tx[0] == "w":
                print(f'    R0_en = 0;', file=f)
                print(f'    W0_en = 1;', file=f)
                print(f'    W0_addr = {tx[1]};', file=f)
                print(f'    W0_data = \'h{tx[2]:x};', file=f)
                if "mwrite" in ports:
                    print(f'    W0_mask = \'h{tx[3]:x};', file=f)
                print(f'    #10;', file=f)
            elif tx[0] == "r":
                print(f'    R0_en = 1;', file=f)
                print(f'    W0_en = 0;', file=f)
                print(f'    R0_addr = {tx[1]};', file=f)
                print(f'    #10;', file=f)
                print(
                    f'    if (R0_data !== \'h{tx[2]:x}) begin', file=f)
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
                if tx[1] == tx[3]:
                    # conflict, allow x/old/new
                    print(
                        f'    if (R0_data !== \'h{tx[4]:x} && R0_data !== \'h{tx[5]:x} && R0_data !== {{{width}{{1\'bx}}}}) begin', file=f)
                else:
                    # not conflict
                    print(
                        f'    if (R0_data !== \'h{tx[4]:x}) begin', file=f)
                print(f'      $display("ASSERTION FAILED");', file=f)
                print(f'      $finish;', file=f)
                print(f'    end', file=f)
            else:
                print(f'    R0_en = 0;', file=f)
                print(f'    W0_en = 0;', file=f)
                print(f'    #10;', file=f)

        print(f'    $display("SIMULATION SUCCESS");', file=f)
        print(f'    $finish;', file=f)
        print(f'  end', file=f)

        print(f'  always #5 R0_clk = ~R0_clk;', file=f)
        print(f'  always #5 W0_clk = ~W0_clk;', file=f)

        print(f'  {config.name} inst (', file=f)
        print(f'    .R0_addr(R0_addr),', file=f)
        print(f'    .R0_en(R0_en),', file=f)
        print(f'    .R0_clk(R0_clk),', file=f)
        print(f'    .R0_data(R0_data),', file=f)
        print(f'    .W0_addr(W0_addr),', file=f)
        print(f'    .W0_en(W0_en),', file=f)
        print(f'    .W0_clk(W0_clk),', file=f)
        if "mwrite" in ports:
            print(f'    .W0_mask(W0_mask),', file=f)
        print(f'    .W0_data(W0_data)', file=f)
        print(f'  );', file=f)
    print(f'endmodule', file=f)
    return f.getvalue()
