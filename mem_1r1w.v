// Generate by chisel-memory-lower
// Config(name='mem_1r1w', depth='32', width='64', ports='write,read', mask_gran=None)
module mem_1r1w (
  input [4:0] R0_addr,
  input R0_en,
  input R0_clk,
  output [63:0] R0_data,
  input [4:0] W0_addr,
  input W0_en,
  input W0_clk,
  input [63:0] W0_data
);
  xpm_memory_sdpram #(
    .ADDR_WIDTH_A(5),
    .ADDR_WIDTH_B(5),
    .BYTE_WRITE_WIDTH_A(64),
    .MEMORY_SIZE(2048),
    .READ_DATA_WIDTH_B(64),
    .READ_LATENCY_B(1),
    .WRITE_DATA_WIDTH_A(64)
  ) xpm_memory_sdpram_inst (
    .dina(W0_data),
    .addra(W0_addr),
    .ena(W0_en),
    .wea(W0_en),
    .clka(W0_clk),
    .addrb(R0_addr),
    .clkb(R0_clk),
    .enb(R0_en),
    .doutb(R0_data),
    .rstb(1'b0),
  );
endmodule
