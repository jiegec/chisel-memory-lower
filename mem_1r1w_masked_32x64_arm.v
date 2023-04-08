// Generate by chisel-memory-lower
// Target: arm
// Config(name='mem_1r1w_masked_32x64', depth='32', width='64', ports='mwrite,read', mask_gran='8')
`timescale 1ns/1ps
module mem_1r1w_masked_32x64 (
  input [4:0] R0_addr,
  input R0_en,
  input R0_clk,
  output [63:0] R0_data,
  input [4:0] W0_addr,
  input W0_en,
  input W0_clk,
  input [63:0] W0_data,
  input [7:0] W0_mask
);

  wire read_addr_match_0 = (R0_addr >> 5) == 0;
  wire write_addr_match_0 = (W0_addr >> 5) == 0;
  wire [63:0] read_data_0;
  assign R0_data = read_data_0;
  rf2_32x128_wm1 inst_0_0 (
    .AA(R0_addr),
    .CENA(~(R0_en && read_addr_match_0)),
    .CLKA(R0_clk),
    .QA(read_data_0[63:0]),
    .AB(W0_addr),
    .CENB(~(W0_en && write_addr_match_0)),
    .CLKB(W0_clk),
    .DB(W0_data[63:0]),
    .WENB(~({W0_mask[7], W0_mask[7], W0_mask[7], W0_mask[7], W0_mask[7], W0_mask[7], W0_mask[7], W0_mask[7], W0_mask[6], W0_mask[6], W0_mask[6], W0_mask[6], W0_mask[6], W0_mask[6], W0_mask[6], W0_mask[6], W0_mask[5], W0_mask[5], W0_mask[5], W0_mask[5], W0_mask[5], W0_mask[5], W0_mask[5], W0_mask[5], W0_mask[4], W0_mask[4], W0_mask[4], W0_mask[4], W0_mask[4], W0_mask[4], W0_mask[4], W0_mask[4], W0_mask[3], W0_mask[3], W0_mask[3], W0_mask[3], W0_mask[3], W0_mask[3], W0_mask[3], W0_mask[3], W0_mask[2], W0_mask[2], W0_mask[2], W0_mask[2], W0_mask[2], W0_mask[2], W0_mask[2], W0_mask[2], W0_mask[1], W0_mask[1], W0_mask[1], W0_mask[1], W0_mask[1], W0_mask[1], W0_mask[1], W0_mask[1], W0_mask[0], W0_mask[0], W0_mask[0], W0_mask[0], W0_mask[0], W0_mask[0], W0_mask[0], W0_mask[0]})),
    .COLLDISN(1),
    .DFTRAMBYP(0),
    .EMAA(3),
    .EMAB(3),
    .EMASA(0),
    .RET1N(1),
    .SEA(0),
    .SEB(0),
    .SIA(0),
    .SIB(0),
    .TAA(0),
    .TAB(0),
    .TCENA(0),
    .TCENB(0),
    .TDB(0),
    .TENA(1),
    .TENB(1),
    .TWENB(1)
  );
endmodule
