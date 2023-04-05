from io import StringIO
import click
from chisel_memory_lower.parser import Config, parse
import chisel_memory_lower.xilinx
import chisel_memory_lower.arm



@click.command()
@click.argument('target')
@click.argument('config', type=click.Path(exists=True))
@click.option('-a', '--arm-config', 'arm_config')
def generate(target: str, config: str, arm_config: str):
    content = open(config, 'r').read()
    for mem in parse(content):
        print(f'Generating {mem}')
        if target == "xilinx":
            chisel_memory_lower.xilinx.generate(mem)
        elif target == "arm":
            chisel_memory_lower.arm.generate(mem, arm_config)
        else:
            assert False


if __name__ == '__main__':
    generate()
