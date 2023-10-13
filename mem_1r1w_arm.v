// Generate by chisel-memory-lower
// Target: arm
// Config(name='mem_1r1w', depth='48', width='64', ports='write,read', mask_gran=None)
`timescale 1ns/1ps
module mem_1r1w (
  input [5:0] R0_addr,
  input R0_en,
  input R0_clk,
  output [63:0] R0_data,
  input [5:0] W0_addr,
  input W0_en,
  input W0_clk,
  input [63:0] W0_data
);

  reg [0:0] read_addr_index_reg;
  always @ (posedge R0_clk) begin
    read_addr_index_reg <= R0_addr >> 5;
  end
  wire read_addr_match_0 = (R0_addr >> 5) == 0;
  wire write_addr_match_0 = (W0_addr >> 5) == 0;
  wire [63:0] read_data_0;
  wire [18:0] read_partial_0_0;
  assign read_data_0[15:0] = read_partial_0_0;
  wire [18:0] read_partial_1_0;
  assign read_data_0[31:16] = read_partial_1_0;
  wire [18:0] read_partial_2_0;
  assign read_data_0[47:32] = read_partial_2_0;
  wire [18:0] read_partial_3_0;
  assign read_data_0[63:48] = read_partial_3_0;
  wire read_addr_match_1 = (R0_addr >> 5) == 1;
  wire write_addr_match_1 = (W0_addr >> 5) == 1;
  wire [63:0] read_data_1;
  wire [18:0] read_partial_0_1;
  assign read_data_1[15:0] = read_partial_0_1;
  wire [18:0] read_partial_1_1;
  assign read_data_1[31:16] = read_partial_1_1;
  wire [18:0] read_partial_2_1;
  assign read_data_1[47:32] = read_partial_2_1;
  wire [18:0] read_partial_3_1;
  assign read_data_1[63:48] = read_partial_3_1;
  assign R0_data = ((read_addr_index_reg == 0) ? read_data_0 : ((read_addr_index_reg == 1) ? read_data_1 : 0));
  rf2_32x19_wm0 inst_0_0 (
    .AA(R0_addr[4:0]),
    .CENA(~(R0_en && read_addr_match_0)),
    .CLKA(R0_clk),
    .QA(read_partial_0_0),
    .AB(W0_addr[4:0]),
    .CENB(~(W0_en && write_addr_match_0)),
    .CLKB(W0_clk),
    .DB({3'b0, W0_data[15:0]}),
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
    .TDB(19'b0),
    .TENA(1'b1),
    .TENB(1'b1)
  );
  rf2_32x19_wm0 inst_0_1 (
    .AA(R0_addr[4:0]),
    .CENA(~(R0_en && read_addr_match_1)),
    .CLKA(R0_clk),
    .QA(read_partial_0_1),
    .AB(W0_addr[4:0]),
    .CENB(~(W0_en && write_addr_match_1)),
    .CLKB(W0_clk),
    .DB({3'b0, W0_data[15:0]}),
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
    .TDB(19'b0),
    .TENA(1'b1),
    .TENB(1'b1)
  );
  rf2_32x19_wm0 inst_1_0 (
    .AA(R0_addr[4:0]),
    .CENA(~(R0_en && read_addr_match_0)),
    .CLKA(R0_clk),
    .QA(read_partial_1_0),
    .AB(W0_addr[4:0]),
    .CENB(~(W0_en && write_addr_match_0)),
    .CLKB(W0_clk),
    .DB({3'b0, W0_data[31:16]}),
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
    .TDB(19'b0),
    .TENA(1'b1),
    .TENB(1'b1)
  );
  rf2_32x19_wm0 inst_1_1 (
    .AA(R0_addr[4:0]),
    .CENA(~(R0_en && read_addr_match_1)),
    .CLKA(R0_clk),
    .QA(read_partial_1_1),
    .AB(W0_addr[4:0]),
    .CENB(~(W0_en && write_addr_match_1)),
    .CLKB(W0_clk),
    .DB({3'b0, W0_data[31:16]}),
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
    .TDB(19'b0),
    .TENA(1'b1),
    .TENB(1'b1)
  );
  rf2_32x19_wm0 inst_2_0 (
    .AA(R0_addr[4:0]),
    .CENA(~(R0_en && read_addr_match_0)),
    .CLKA(R0_clk),
    .QA(read_partial_2_0),
    .AB(W0_addr[4:0]),
    .CENB(~(W0_en && write_addr_match_0)),
    .CLKB(W0_clk),
    .DB({3'b0, W0_data[47:32]}),
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
    .TDB(19'b0),
    .TENA(1'b1),
    .TENB(1'b1)
  );
  rf2_32x19_wm0 inst_2_1 (
    .AA(R0_addr[4:0]),
    .CENA(~(R0_en && read_addr_match_1)),
    .CLKA(R0_clk),
    .QA(read_partial_2_1),
    .AB(W0_addr[4:0]),
    .CENB(~(W0_en && write_addr_match_1)),
    .CLKB(W0_clk),
    .DB({3'b0, W0_data[47:32]}),
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
    .TDB(19'b0),
    .TENA(1'b1),
    .TENB(1'b1)
  );
  rf2_32x19_wm0 inst_3_0 (
    .AA(R0_addr[4:0]),
    .CENA(~(R0_en && read_addr_match_0)),
    .CLKA(R0_clk),
    .QA(read_partial_3_0),
    .AB(W0_addr[4:0]),
    .CENB(~(W0_en && write_addr_match_0)),
    .CLKB(W0_clk),
    .DB({3'b0, W0_data[63:48]}),
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
    .TDB(19'b0),
    .TENA(1'b1),
    .TENB(1'b1)
  );
  rf2_32x19_wm0 inst_3_1 (
    .AA(R0_addr[4:0]),
    .CENA(~(R0_en && read_addr_match_1)),
    .CLKA(R0_clk),
    .QA(read_partial_3_1),
    .AB(W0_addr[4:0]),
    .CENB(~(W0_en && write_addr_match_1)),
    .CLKB(W0_clk),
    .DB({3'b0, W0_data[63:48]}),
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
    .TDB(19'b0),
    .TENA(1'b1),
    .TENB(1'b1)
  );
endmodule
