// Generate by chisel-memory-lower
// Target: arm
// Config(name='mem_1rw', depth='48', width='64', ports='rw', mask_gran=None)
`timescale 1ns/1ps
module mem_1rw (
  input [5:0] RW0_addr,
  input RW0_en,
  input RW0_clk,
  input RW0_wmode,
  input [63:0] RW0_wdata,
  output [63:0] RW0_rdata
);

  wire rw_addr_match_0 = (RW0_addr >> 7) == 0;
  wire [63:0] read_data_0;
  wire [63:0] read_partial_0_0;
  assign read_data_0[63:0] = read_partial_0_0;
  assign RW0_rdata = read_data_0;
  sram_1rw_128X64 inst_0_0 (
    .A({1'b0, RW0_addr[5:0]}),
    .CEN(~(RW0_en && rw_addr_match_0)),
    .WEN(~RW0_wmode),
    .CLK(RW0_clk),
    .D(RW0_wdata[63:0]),
    .Q(read_partial_0_0),
    .EMA(3'd3),
    .EMAW(2'd2),
    .RET1N(1'b1)
  );
endmodule
