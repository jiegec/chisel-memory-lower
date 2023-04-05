// Generate by chisel-memory-lower
// Target: arm
// Config(name='mem_1r1w_masked_48x64', depth='48', width='64', ports='mwrite,read', mask_gran='8')
module mem_1r1w_masked_48x64 (
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

  reg [0:0] read_addr_index_reg;
  always @ (posedge R0_clk) begin
    read_addr_index_reg <= R0_addr >> 5;
  end
  wire read_addr_match_0 = (R0_addr >> 5) == 0;
  wire write_addr_match_0 = (W0_addr >> 5) == 0;
  wire [63:0] read_data_0;
  wire read_addr_match_1 = (R0_addr >> 5) == 1;
  wire write_addr_match_1 = (W0_addr >> 5) == 1;
  wire [63:0] read_data_1;
  assign R0_data = \
    ((read_addr_index_reg == 0) ? read_data_0 : \
      ((read_addr_index_reg == 1) ? read_data_1 : \
    0));
  rf2_32x128_wm1 inst_0_0 (
    .AA(R0_addr),
    .CENA(R0_en && read_addr_match_0),
    .CLKA(R0_clk),
    .QA(read_data_0[63:0]),
    .AB(W0_addr),
    .CENB(W0_en && write_addr_match_0),
    .CLKB(W0_clk),
    .DB(W0_data[63:0]),
  );
  rf2_32x128_wm1 inst_0_1 (
    .AA(R0_addr),
    .CENA(R0_en && read_addr_match_1),
    .CLKA(R0_clk),
    .QA(read_data_1[63:0]),
    .AB(W0_addr),
    .CENB(W0_en && write_addr_match_1),
    .CLKB(W0_clk),
    .DB(W0_data[63:0]),
  );
endmodule
