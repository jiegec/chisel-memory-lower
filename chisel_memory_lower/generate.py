import click
from chisel_memory_lower.parser import parse
import chisel_memory_lower.xilinx


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
