import math
from chisel_memory_lower.utils import generate_header
from chisel_memory_lower.parser import Config
from collections import namedtuple
import yaml


def generate(config: Config, arm_config: str):
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
            print(selected)
        print(f'endmodule', file=f)
        pass
