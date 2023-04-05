from chisel_memory_lower.utils import generate_header
from chisel_memory_lower.parser import Config
from collections import namedtuple


def generate(config: Config, arm_config: str):
    with open(f'{config.name}_arm.v', 'w') as f:
        ports = set(config.ports.split(','))
        depth = int(config.depth)
        width = int(config.width)
        addr_width = (depth-1).bit_length()
        header = generate_header(config, 'arm')
        print(header, file=f)

        if ports == {"read", "write"}:
            # 1R1W
            pass
        print(f'endmodule', file=f)
        pass
