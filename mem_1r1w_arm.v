// Generate by chisel-memory-lower
// Target: arm
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

  rf2_32x19_wm0 inst_0_0 (
    .AA(R0_addr),
    .CENA(R0_en),
    .CLKA(R0_clk),
    .QA(R0_data[15:0]),
    .AB(W0_addr),
    .CENB(W0_en),
    .CLKB(W0_clk),
    .DB(W0_data[15:0]),
  );
  rf2_32x19_wm0 inst_1_0 (
    .AA(R0_addr),
    .CENA(R0_en),
    .CLKA(R0_clk),
    .QA(R0_data[31:16]),
    .AB(W0_addr),
    .CENB(W0_en),
    .CLKB(W0_clk),
    .DB(W0_data[31:16]),
  );
  rf2_32x19_wm0 inst_2_0 (
    .AA(R0_addr),
    .CENA(R0_en),
    .CLKA(R0_clk),
    .QA(R0_data[47:32]),
    .AB(W0_addr),
    .CENB(W0_en),
    .CLKB(W0_clk),
    .DB(W0_data[47:32]),
  );
  rf2_32x19_wm0 inst_3_0 (
    .AA(R0_addr),
    .CENA(R0_en),
    .CLKA(R0_clk),
    .QA(R0_data[63:48]),
    .AB(W0_addr),
    .CENB(W0_en),
    .CLKB(W0_clk),
    .DB(W0_data[63:48]),
  );
endmodule
