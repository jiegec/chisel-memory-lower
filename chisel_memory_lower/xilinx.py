import os
from chisel_memory_lower.utils import generate_header, generate_tb
from chisel_memory_lower.parser import Config


def generate(config: Config, tb: bool):
    with open(f'{config.name}_xilinx.v', 'w') as f:
        ports = set(config.ports.split(','))
        depth = int(config.depth)
        width = int(config.width)
        addr_width = (depth-1).bit_length()
        header = generate_header(config, 'xilinx')
        print(header, file=f)

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
            print(f'    .wea(RW0_wmode)', file=f)
            print(f'  );', file=f)
        elif ports == {"read", "write"}:
            # 1R1W
            print(f'  xpm_memory_sdpram #(', file=f)
            print(f'    .ADDR_WIDTH_A({addr_width}),', file=f)
            print(f'    .ADDR_WIDTH_B({addr_width}),', file=f)
            print(f'    .BYTE_WRITE_WIDTH_A({width}),', file=f)
            print(f'    .MEMORY_SIZE({width * depth}),', file=f)
            print(f'    .READ_DATA_WIDTH_B({width}),', file=f)
            print(f'    .READ_LATENCY_B(1),', file=f)
            print(f'    .WRITE_DATA_WIDTH_A({width})', file=f)
            print(f'  ) xpm_memory_sdpram_inst (', file=f)
            print(f'    .dina(W0_data),', file=f)
            print(f'    .addra(W0_addr),', file=f)
            print(f'    .ena(W0_en),', file=f)
            print(f'    .wea(W0_en),', file=f)
            print(f'    .clka(W0_clk),', file=f)
            print(f'    .addrb(R0_addr),', file=f)
            print(f'    .clkb(R0_clk),', file=f)
            print(f'    .enb(R0_en),', file=f)
            print(f'    .doutb(R0_data),', file=f)
            print(f'    .rstb(1\'b0)', file=f)
            print(f'  );', file=f)
        elif ports == {"read", "mwrite"}:
            # 1R1W Masked
            mask_gran = int(config.mask_gran)
            print(f'  xpm_memory_sdpram #(', file=f)
            print(f'    .ADDR_WIDTH_A({addr_width}),', file=f)
            print(f'    .ADDR_WIDTH_B({addr_width}),', file=f)
            print(f'    .BYTE_WRITE_WIDTH_A({mask_gran}),', file=f)
            print(f'    .MEMORY_SIZE({width * depth}),', file=f)
            print(f'    .READ_DATA_WIDTH_B({width}),', file=f)
            print(f'    .READ_LATENCY_B(1),', file=f)
            print(f'    .WRITE_DATA_WIDTH_A({width})', file=f)
            print(f'  ) xpm_memory_sdpram_inst (', file=f)
            print(f'    .dina(W0_data),', file=f)
            print(f'    .addra(W0_addr),', file=f)
            print(f'    .ena(W0_en),', file=f)
            print(f'    .wea(W0_mask),', file=f)
            print(f'    .clka(W0_clk),', file=f)
            print(f'    .addrb(R0_addr),', file=f)
            print(f'    .clkb(R0_clk),', file=f)
            print(f'    .enb(R0_en),', file=f)
            print(f'    .doutb(R0_data),', file=f)
            print(f'    .rstb(1\'b0)', file=f)
            print(f'  );', file=f)
        print(f'endmodule', file=f)

    vivado_version = '2020.2'
    with open(f'{config.name}_xilinx.prj', 'w') as file:
        print(f'verilog work {config.name}_xilinx.v', file=file)
        print(f'verilog work {config.name}_xilinx_tb.v', file=file)
        print(
            f'sv work /opt/Xilinx/Vivado/{vivado_version}/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv', file=file)

    with open(f'{config.name}_xilinx.sh', 'w') as file:
        print(f'#!/bin/bash', file=file)
        print(
            f'export PATH=/opt/Xilinx/Vivado/{vivado_version}/bin:$PATH', file=file)
        print(
            f'xelab -debug all {config.name}_tb -prj {config.name}_xilinx.prj', file=file)
        print(f'xsim {config.name}_tb --tclbatch sim.tcl', file=file)
    os.chmod(f'{config.name}_xilinx.sh', 0o755)

    with open(f'{config.name}_xilinx_tb.v', 'w') as f:
        tb = generate_tb(config)
        print(tb, file=f)
