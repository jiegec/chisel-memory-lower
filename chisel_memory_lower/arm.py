import math
import os
from chisel_memory_lower.utils import generate_header, generate_tb
from chisel_memory_lower.parser import Config
from collections import namedtuple
import yaml


def generate(config: Config, arm_config: str, tb: bool):
    cfg = yaml.load(open(arm_config, 'r'), Loader=yaml.Loader)
    ip = cfg['ip']
    ports = set(config.ports.split(','))
    depth = int(config.depth)
    width = int(config.width)
    addr_width = (depth-1).bit_length()

    types = ''
    if ports == {"read", "write"}:
        # 1R1W
        types = ['1r1w', '1r1w_masked']
    elif ports == {"read", "mwrite"}:
        # 1R1W Masked
        types = ['1r1w_masked']
    elif ports == {"rw"}:
        # 1RW
        types = ['1rw', '1rw_masked']
    elif ports == {"mrw"}:
        # 1RW Masked
        types = ['1rw_masked']
    candidates = list(filter(lambda c: c['type'] in types, ip))
    if len(candidates) > 0:
        with open(f'{config.name}_arm.v', 'w') as f:
            header = generate_header(config, 'arm')
            print(header, file=f)
            selected = min(candidates, key=lambda candidate: math.ceil(width / candidate['width']) *
                           math.ceil(depth / candidate['depth']) * candidate['cost'])
            print(f"Using sram ip {selected['name']}")

            width_replicate = math.ceil(width / selected['width'])
            depth_replicate = math.ceil(depth / selected['depth'])
            selected_addr_width = (selected['depth']-1).bit_length()

            if addr_width > selected_addr_width:
                if ports == {"rw"} or ports == {"mrw"}:
                    print(
                        f'  reg [{addr_width-selected_addr_width-1}:0] rw_addr_index_reg;', file=f)
                    print(f'  always @ (posedge RW0_clk) begin', file=f)
                    print(
                        f'    rw_addr_index_reg <= RW0_addr >> {selected_addr_width};', file=f)
                    print(f'  end', file=f)
                else:
                    print(
                        f'  reg [{addr_width-selected_addr_width-1}:0] read_addr_index_reg;', file=f)
                    print(f'  always @ (posedge R0_clk) begin', file=f)
                    print(
                        f'    read_addr_index_reg <= R0_addr >> {selected_addr_width};', file=f)
                    print(f'  end', file=f)

            for j in range(depth_replicate):
                if ports == {"rw"} or ports == {"mrw"}:
                    print(
                        f'  wire rw_addr_match_{j} = (RW0_addr >> {selected_addr_width}) == {j};', file=f)
                    print(f'  wire [{width-1}:0] read_data_{j};', file=f)
                    for i in range(width_replicate):
                        width_start = i * width // width_replicate
                        width_end = (i+1) * width // width_replicate
                        print(
                            f'  wire [{selected["width"]-1}:0] read_partial_{i}_{j};', file=f)
                        print(
                            f'  assign read_data_{j}[{width_end-1}:{width_start}] = read_partial_{i}_{j};', file=f)
                else:
                    print(
                        f'  wire read_addr_match_{j} = (R0_addr >> {selected_addr_width}) == {j};', file=f)
                    print(
                        f'  wire write_addr_match_{j} = (W0_addr >> {selected_addr_width}) == {j};', file=f)
                    print(f'  wire [{width-1}:0] read_data_{j};', file=f)
                    for i in range(width_replicate):
                        width_start = i * width // width_replicate
                        width_end = (i+1) * width // width_replicate
                        print(
                            f'  wire [{selected["width"]-1}:0] read_partial_{i}_{j};', file=f)
                        print(
                            f'  assign read_data_{j}[{width_end-1}:{width_start}] = read_partial_{i}_{j};', file=f)

            if addr_width > selected_addr_width:
                if ports == {"rw"} or ports == {"mrw"}:
                    print(f'  assign RW0_rdata = ', file=f, end='')
                    for j in range(depth_replicate):
                        print(
                            f'((rw_addr_index_reg == {j}) ? read_data_{j} : ', file=f, end='')
                    print(f'0{")" * depth_replicate};', file=f)
                else:
                    print(f'  assign R0_data = ', file=f, end='')
                    for j in range(depth_replicate):
                        print(
                            f'((read_addr_index_reg == {j}) ? read_data_{j} : ', file=f, end='')
                    print(f'0{")" * depth_replicate};', file=f)
            else:
                if ports == {"rw"} or ports == {"mrw"}:
                    print(f'  assign RW0_rdata = read_data_0;', file=f)
                else:
                    print(f'  assign R0_data = read_data_0;', file=f)

            for i in range(width_replicate):
                width_start = i * width // width_replicate
                width_end = (i+1) * width // width_replicate
                data_width = width_end - width_start
                for j in range(depth_replicate):
                    print(f'  {selected["name"]} inst_{i}_{j} (', file=f)
                    pins = []
                    for port in selected["ports"]:
                        sram_depth_bits = (
                            selected['depth']-1).bit_length()
                        actual_depth_bits = min(
                            sram_depth_bits, (depth-1).bit_length())
                        if port["type"] == "r":
                            # connect addr
                            addr = f"R0_addr[{actual_depth_bits-1}:0]"
                            if actual_depth_bits < sram_depth_bits:
                                addr = f"{{{sram_depth_bits - actual_depth_bits}'b0, {addr}}}"
                            pins.append(
                                (port["addr"], addr))

                            pins.append(
                                (port["enable_n"], f"~(R0_en && read_addr_match_{j})"))
                            pins.append((port["clock"], f"R0_clk"))
                            pins.append(
                                (port["data"], f"read_partial_{i}_{j}"))
                        elif port["type"] == "w":
                            # connect addr
                            addr = f"W0_addr[{actual_depth_bits-1}:0]"
                            if actual_depth_bits < sram_depth_bits:
                                addr = f"{{{sram_depth_bits - actual_depth_bits}'b0, {addr}}}"
                            pins.append(
                                (port["addr"], addr))

                            pins.append(
                                (port["enable_n"], f"~(W0_en && write_addr_match_{j})"))
                            if "clock" in port:
                                pins.append((port["clock"], f"W0_clk"))
                            else:
                                print("CAUTION! clock is missing in write port, please ensure R0_clk and W0_clk connect to the same signal.")

                            # pad to full width
                            data = f'W0_data[{width_end-1}:{width_start}]'
                            if data_width < selected['width']:
                                data = f"{{{selected['width'] - data_width}'b0, {data}}}"
                            pins.append(
                                (port["data"], data))

                            if "mask_n" in port:
                                if ports == {"read", "mwrite"}:
                                    # 1R1W Masked
                                    bits = []
                                    for bit in range(width_start, width_end):
                                        mask_bit = bit // int(config.mask_gran)
                                        bits.append(f'W0_mask[{mask_bit}]')

                                    # pad to full width
                                    bits += ["1'b0"] * \
                                        (selected['width'] - data_width)

                                    rhs = ', '.join(reversed(bits))
                                    pins.append(
                                        (port["mask_n"], f'~({{{rhs}}})'))
                                else:
                                    # all mask enabled
                                    pins.append(
                                        (port["mask_n"], f'{{{selected["width"]}{{1\'b0}}}}'))
                        elif port["type"] == "rw":
                            # connect addr
                            sram_depth_bits = (
                                selected['depth']-1).bit_length()
                            actual_depth_bits = min(
                                sram_depth_bits, (depth-1).bit_length())
                            addr = f"RW0_addr[{actual_depth_bits-1}:0]"
                            if actual_depth_bits < sram_depth_bits:
                                addr = f"{{{sram_depth_bits - actual_depth_bits}'b0, {addr}}}"
                            pins.append(
                                (port["addr"], addr))

                            pins.append(
                                (port["enable_n"], f"~(RW0_en && rw_addr_match_{j})"))
                            pins.append((port["write_n"], f"~RW0_wmode"))
                            pins.append((port["clock"], f"RW0_clk"))
                            # pad to full width
                            wdata = f'RW0_wdata[{width_end-1}:{width_start}]'
                            if data_width < selected['width']:
                                wdata = f"{{{selected['width'] - data_width}'b0, {wdata}}}"
                            pins.append(
                                (port["wdata"], wdata))
                            pins.append(
                                (port["rdata"], f"read_partial_{i}_{j}"))

                            if "mask_n" in port:
                                if ports == {"mrw"}:
                                    # 1RW Masked
                                    bits = []
                                    for bit in range(width_start, width_end):
                                        mask_bit = bit // int(config.mask_gran)
                                        bits.append(f'RW0_wmask[{mask_bit}]')

                                    # pad to full width
                                    bits += ["1'b0"] * \
                                        (selected['width'] - data_width)

                                    rhs = ', '.join(reversed(bits))
                                    pins.append(
                                        (port["mask_n"], f'~({{{rhs}}})'))
                                else:
                                    # all mask enabled
                                    pins.append(
                                        (port["mask_n"], f'{{{selected["width"]}{{1\'b0}}}}'))
                    if "constants" in selected:
                        for name in selected["constants"]:
                            value = selected["constants"][name]
                            pins.append((name, value))

                    for k in range(len(pins)):
                        if k == len(pins)-1:
                            end = ''
                        else:
                            end = ','
                        print(
                            f'    .{pins[k][0]}({pins[k][1]}){end}', file=f)
                    print(f'  );', file=f)
            print(f'endmodule', file=f)

        with open(f'{config.name}_arm.sh', 'w') as file:
            print(f'#!/bin/bash', file=file)
            print(
                f'vcs +vcs+dumpvars+dump.vcd -full64 {config.name}_arm.v {config.name}_arm_tb.v {selected["name"]}.v', file=file)
            print(f'./simv', file=file)
        os.chmod(f'{config.name}_arm.sh', 0o755)

        with open(f'{config.name}_arm_tb.v', 'w') as f:
            tb = generate_tb(config)
            print(tb, file=f)
