import math
from chisel_memory_lower.utils import generate_header
from chisel_memory_lower.parser import Config
from collections import namedtuple
import yaml


def generate(config: Config, arm_config: str, tb: bool):
    cfg = yaml.load(open(arm_config, 'r'), Loader=yaml.Loader)
    ip = cfg['ip']
    with open(f'{config.name}_arm.v', 'w') as f:
        ports = set(config.ports.split(','))
        depth = int(config.depth)
        width = int(config.width)
        addr_width = (depth-1).bit_length()
        header = generate_header(config, 'arm')
        print(header, file=f)

        types = ''
        if ports == {"read", "write"}:
            # 1R1W
            types = ['1r1w', '1r1w_masked']
        elif ports == {"rw"}:
            # 1RW
            types = ['1rw']
        elif ports == {"read", "mwrite"}:
            # 1R1W Masked
            types = ['1r1w_masked']
        candidates = list(filter(lambda c: c['type'] in types, ip))
        if len(candidates) > 0:
            selected = min(candidates, key=lambda candidate: math.ceil(width / candidate['width']) *
                           math.ceil(depth / candidate['depth']) * candidate['cost'])
            print(f"Using sram ip {selected['name']}")

            width_replicate = math.ceil(width / selected['width'])
            depth_replicate = math.ceil(depth / selected['depth'])
            selected_addr_width = (selected['depth']-1).bit_length()

            if addr_width > selected_addr_width:
                print(
                    f'  reg [{addr_width-selected_addr_width-1}:0] read_addr_index_reg;', file=f)
                print(f'  always @ (posedge R0_clk) begin', file=f)
                print(
                    f'    read_addr_index_reg <= R0_addr >> {selected_addr_width};', file=f)
                print(f'  end', file=f)

            for j in range(depth_replicate):
                print(
                    f'  wire read_addr_match_{j} = (R0_addr >> {selected_addr_width}) == {j};', file=f)
                print(
                    f'  wire write_addr_match_{j} = (W0_addr >> {selected_addr_width}) == {j};', file=f)
                print(f'  wire [{width-1}:0] read_data_{j};', file=f)

            if addr_width > selected_addr_width:
                print(f'  assign R0_data = \\', file=f)
                for j in range(depth_replicate):
                    print(
                        f'    {"  " * j}((read_addr_index_reg == {j}) ? read_data_{j} : \\', file=f)
                print(f'    0{")" * depth_replicate};', file=f)
            else:
                print(f'  assign R0_data = read_data_0;', file=f)

            for i in range(width_replicate):
                width_start = i * width // width_replicate
                width_end = (i+1) * width // width_replicate
                for j in range(depth_replicate):
                    print(f'  {selected["name"]} inst_{i}_{j} (', file=f)
                    pins = []
                    for port in selected["ports"]:
                        if port["type"] == "r":
                            pins.append((port["addr"], f"R0_addr"))
                            pins.append(
                                (port["enable_n"], f"~(R0_en && read_addr_match_{j})"))
                            pins.append((port["clock"], f"R0_clk"))
                            pins.append(
                                (port["data"], f"read_data_{j}[{width_end-1}:{width_start}]"))
                        elif port["type"] == "w":
                            pins.append((port["addr"], f"W0_addr"))
                            pins.append(
                                (port["enable_n"], f"~(W0_en && write_addr_match_{j})"))
                            pins.append((port["clock"], f"W0_clk"))
                            pins.append(
                                (port["data"], f"W0_data[{width_end-1}:{width_start}]"))
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
        pass
