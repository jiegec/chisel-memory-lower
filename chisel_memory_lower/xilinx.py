from chisel_memory_lower.parser import Config


def generate(config: Config):
    with open(f'{config.name}.v', 'w') as f:
        ports = set(config.ports.split(','))
        depth = int(config.depth)
        width = int(config.width)
        addr_width = (depth-1).bit_length()
        print(f'// Generate by chisel-memory-lower', file=f)
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
        print(f');', file=f)
        if ports == {"rw"}:
            # 1RW
            print(f'  xpm_memory_spram #(', file=f)
            print(f'    .ADDR_WIDTH_A({addr_width}),', file=f)
            print(f'    .BYTE_WRITE_WIDTH_A({width}),', file=f)
            print(f'    .MEMORY_SIZE({width * depth}),', file=f)
            print(f'    .READ_DATA_WIDTH_A({width}),', file=f)
            print(f'    .READ_LATENCY_A(1),', file=f)
            print(f'    .WRITE_DATA_WIDTH_A({width})', file=f)
            print(f'  ) xpm_memory_spram_inst (', file=f)
            print(f'    .douta(RW0_rdata),', file=f)
            print(f'    .addra(RW0_addr),', file=f)
            print(f'    .clka(RW0_clk),', file=f)
            print(f'    .dina(RW0_wdata),', file=f)
            print(f'    .ena(RW0_en),', file=f)
            print(f'    .rsta(1\'b0),', file=f)
            print(f'    .wea(RW0_wmode),', file=f)
            print(f'  );', file=f)
        print(f'endmodule', file=f)
        pass
