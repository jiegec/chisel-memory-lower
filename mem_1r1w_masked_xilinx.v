// Generate by chisel-memory-lower
// Target: xilinx
// Config(name='mem_1r1w_masked', depth='48', width='64', ports='mwrite,read', mask_gran='8')
module mem_1r1w_masked (
  input [5:0] R0_addr,
  input R0_en,
  input R0_clk,
  output [63:0] R0_data,
  input [5:0] W0_addr,
  input W0_en,
  input W0_clk,
  input [63:0] W0_data,
  input [7:0] W0_mask
);

  xpm_memory_sdpram #(
    .ADDR_WIDTH_A(6),
    .ADDR_WIDTH_B(6),
    .BYTE_WRITE_WIDTH_A(8),
    .MEMORY_SIZE(3072),
    .READ_DATA_WIDTH_B(64),
    .READ_LATENCY_B(1),
    .WRITE_DATA_WIDTH_A(64)
  ) xpm_memory_sdpram_inst (
    .dina(W0_data),
    .addra(W0_addr),
    .ena(W0_en),
    .wea(W0_mask),
    .clka(W0_clk),
    .addrb(R0_addr),
    .clkb(R0_clk),
    .enb(R0_en),
    .doutb(R0_data),
    .rstb(1'b0)
  );
endmodule
