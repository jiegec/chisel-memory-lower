from io import StringIO
import click
from chisel_memory_lower.parser import Config, parse
import chisel_memory_lower.xilinx


def generate_header(config: Config) -> str:
    f = StringIO()
    ports = set(config.ports.split(','))
    depth = int(config.depth)
    width = int(config.width)
    addr_width = (depth-1).bit_length()
    print(f'// Generate by chisel-memory-lower', file=f)
    print(f'// Target: xilinx', file=f)
    print(f'// {config}', file=f)
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


@click.command()
@click.argument('target')
@click.argument('config')
def generate(target: str, config: str):
    content = open(config, 'r').read()
    for mem in parse(content):
        print(mem)
        if target == "xilinx":
            chisel_memory_lower.xilinx.generate(mem)
        else:
            assert False


if __name__ == '__main__':
    generate()
