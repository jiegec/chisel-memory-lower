import click
from chisel_memory_lower.parser import Config, parse
import chisel_memory_lower.xilinx
import chisel_memory_lower.arm


@click.command()
@click.argument('target')
@click.argument('config', type=click.Path(exists=True))
@click.option('-a', '--arm-config', 'arm_config', help="Configuration file for IP")
@click.option('-t', '--tb', is_flag=True, help="Generate testbench")
@click.option('-v', '--vivado-path', 'vivado_path', help="Path to vivado installation", default="/opt/Xilinx/Vivado/2020.2")
def generate(target: str, config: str, arm_config: str, tb: bool, vivado_path: str):
    content = open(config, 'r').read()
    for mem in parse(content):
        print(f'Generating {mem}')
        if target == "xilinx":
            chisel_memory_lower.xilinx.generate(mem, tb, vivado_path)
        elif target == "arm":
            chisel_memory_lower.arm.generate(mem, arm_config, tb)
        else:
            assert False


if __name__ == '__main__':
    generate()
