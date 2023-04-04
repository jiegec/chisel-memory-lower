
def parse(content: str):
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
        print(info)
