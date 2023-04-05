from collections import namedtuple
from typing import List


Config = namedtuple(
    'Config', 'name, depth, width, ports, mask_gran', defaults=(None,) * 5)


def parse(content: str) -> List[Config]:
    configs = []
    for line in content.splitlines():
        parts = line.split(' ')
        parts = list(filter(lambda s: len(s) > 0, parts))
        if len(parts) % 2 != 0:
            continue
        info = {}
        for i in range(len(parts) // 2):
            key = parts[i * 2]
            value = parts[i * 2 + 1]
            info[key] = value
        config = Config(**info)
        configs.append(config)
    return configs
