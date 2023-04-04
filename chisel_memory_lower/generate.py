import click
from chisel_memory_lower.parser import parse


@click.command()
@click.argument('target')
@click.argument('config')
def generate(target: str, config: str):
    content = open(config, 'r').read()
    print(parse(content))
    print(target)


if __name__ == '__main__':
    generate()
