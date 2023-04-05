// Generate by chisel-memory-lower
// Target: arm
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

  rf2_32x128_wm1 inst_0_0 (
    .AA(R0_addr),
    .CENA(R0_en && ((R0_addr >> 5) == 0)),
    .CLKA(R0_clk),
    .QA(R0_data[63:0]),
    .AB(W0_addr),
    .CENB(W0_en && ((W0_addr >> 5) == 0)),
    .CLKB(W0_clk),
    .DB(W0_data[63:0]),
  );
  rf2_32x128_wm1 inst_0_1 (
    .AA(R0_addr),
    .CENA(R0_en && ((R0_addr >> 5) == 1)),
    .CLKA(R0_clk),
    .QA(R0_data[63:0]),
    .AB(W0_addr),
    .CENB(W0_en && ((W0_addr >> 5) == 1)),
    .CLKB(W0_clk),
    .DB(W0_data[63:0]),
  );
endmodule
