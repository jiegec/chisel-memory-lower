// Generate by chisel-memory-lower
// Target: xilinx
// Config(name='mem_1rw', depth='48', width='64', ports='rw', mask_gran=None)
module mem_1rw (
  input [5:0] RW0_addr,
  input RW0_en,
  input RW0_clk,
  input RW0_wmode,
  input [63:0] RW0_wdata,
  output [63:0] RW0_rdata
);

  xpm_memory_spram #(
    .ADDR_WIDTH_A(6),
    .BYTE_WRITE_WIDTH_A(64),
    .MEMORY_SIZE(3072),
    .READ_DATA_WIDTH_A(64),
    .READ_LATENCY_A(1),
    .WRITE_DATA_WIDTH_A(64)
  ) xpm_memory_spram_inst (
    .douta(RW0_rdata),
    .addra(RW0_addr),
    .clka(RW0_clk),
    .dina(RW0_wdata),
    .ena(RW0_en),
    .rsta(1'b0),
    .wea(RW0_wmode)
  );
endmodule
