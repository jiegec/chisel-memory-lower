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
    .COLLDISN(1'b1),
    .DFTRAMBYP(1'b0),
    .EMAA(3'd3),
    .EMAB(3'd3),
    .EMASA(1'b0),
    .RET1N(1'b1),
    .SEA(1'b0),
    .SEB(1'b0),
    .SIA(2'b0),
    .SIB(2'b0),
    .TAA(5'b0),
    .TAB(5'b0),
    .TCENA(1'b0),
    .TCENB(1'b0),
    .TDB(128'b0),
    .TENA(1'b1),
    .TENB(1'b1),
    .TWENB({128{1'b1}})
  );
endmodule
