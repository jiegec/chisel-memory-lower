// Generate by chisel-memory-lower
// Target: xilinx
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
module mem_1rw_tb (
);
  reg [5:0] RW0_addr;
  reg RW0_en;
  reg RW0_clk;
  reg RW0_wmode;
  reg [63:0] RW0_wdata;
  wire [63:0] RW0_rdata;
  initial begin
    RW0_clk = 1;
    RW0_en = 0;
    RW0_wmode = 0;
    RW0_addr = 0;
    RW0_wdata = 0;
    #1;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 0;
    RW0_wdata = 'h6baa9455e3e70682;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 1;
    RW0_wdata = 'hd4713d60c8a70639;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 2;
    RW0_wdata = 'h7a024204f7c1bd87;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 3;
    RW0_wdata = 'h8133287637ebdcd9;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 4;
    RW0_wdata = 'h4f65d4d9259f4329;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 5;
    RW0_wdata = 'haf19922ad9b8a714;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 6;
    RW0_wdata = 'h8f4ff31e78de5857;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 7;
    RW0_wdata = 'h6f25e2a25a921187;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 8;
    RW0_wdata = 'h42af9fc385776e9a;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 9;
    RW0_wdata = 'h3983ca8ea7e9d49;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 10;
    RW0_wdata = 'hd71037d1b83e90ec;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 11;
    RW0_wdata = 'ha0116be5ab0c1681;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 12;
    RW0_wdata = 'h55485822de1b372a;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 13;
    RW0_wdata = 'h101fbcccded733e8;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 14;
    RW0_wdata = 'h9148624feac1c14f;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 15;
    RW0_wdata = 'h1759edc372ae2244;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 16;
    RW0_wdata = 'h1beb37117d41e602;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 17;
    RW0_wdata = 'h8c25166a1ff39849;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 18;
    RW0_wdata = 'h71eacd0549a3e80e;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 19;
    RW0_wdata = 'hcc45782198a6416d;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 20;
    RW0_wdata = 'h935ddd725129fb7c;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 21;
    RW0_wdata = 'h2f1205544a5308cc;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 22;
    RW0_wdata = 'h2fcd81b5d24bace4;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 23;
    RW0_wdata = 'h79fdef7c42930b33;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 24;
    RW0_wdata = 'he07405eb215663ab;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 25;
    RW0_wdata = 'h864a7a50b48d73f1;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 26;
    RW0_wdata = 'hcfc6e62585940927;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 27;
    RW0_wdata = 'h73581a8146743741;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 28;
    RW0_wdata = 'h5b7c709acb175a5a;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 29;
    RW0_wdata = 'h9cdf5a865306f3f5;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 30;
    RW0_wdata = 'hd857010255d44936;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 31;
    RW0_wdata = 'h552116dd2ba4b180;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 32;
    RW0_wdata = 'hfebd845d0dfae43;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 33;
    RW0_wdata = 'h38018b47b29a8b06;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 34;
    RW0_wdata = 'hae3b16ec9a27d858;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 35;
    RW0_wdata = 'h1ea45cd69371a71f;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 36;
    RW0_wdata = 'h1db53334fb0323a1;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 37;
    RW0_wdata = 'h589f8779b025244;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 38;
    RW0_wdata = 'hf87f43fdf6062541;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 39;
    RW0_wdata = 'h1fb797fab7d6467b;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 40;
    RW0_wdata = 'h8b53031d05d51433;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 41;
    RW0_wdata = 'h11ebcd49428a1c22;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 42;
    RW0_wdata = 'ha59cec98126cbc8f;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 43;
    RW0_wdata = 'h6fa231e959acdd98;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 44;
    RW0_wdata = 'h80ee526e0fa07a3f;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 45;
    RW0_wdata = 'h98b33c6e0a14b90a;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 46;
    RW0_wdata = 'hfcfcfa81b306d700;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 47;
    RW0_wdata = 'h429817c53308fb2e;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 46;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'hfcfcfa81b306d700) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 3;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h8133287637ebdcd9) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 21;
    RW0_wdata = 'h402d0baf878b9f6b;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 42;
    RW0_wdata = 'h361524c2cc0f859;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 36;
    RW0_wdata = 'ha62081434fbaecc0;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 42;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h361524c2cc0f859) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 21;
    RW0_wdata = 'h2284b7a447e7f593;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 22;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h2fcd81b5d24bace4) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 15;
    RW0_wdata = 'ha32c9b6f391cf046;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 45;
    RW0_wdata = 'h6a1689addfe1b307;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 44;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h80ee526e0fa07a3f) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 28;
    RW0_wdata = 'he245a4600004884c;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 20;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h935ddd725129fb7c) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 26;
    RW0_wdata = 'hfca055362169df82;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 43;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h6fa231e959acdd98) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 0;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h6baa9455e3e70682) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 12;
    RW0_wdata = 'hdfa7c6ed32d1f81b;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 44;
    RW0_wdata = 'h2ea60b99fa7ff8bf;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 25;
    RW0_wdata = 'h14d30dbca0acf4c9;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 28;
    RW0_wdata = 'hcad6e514ccc14d51;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 8;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h42af9fc385776e9a) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 9;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h3983ca8ea7e9d49) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 2;
    RW0_wdata = 'hae55cdff34ab18fd;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 23;
    RW0_wdata = 'ha7c5cb879b8b71a1;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 40;
    RW0_wdata = 'h2da44da189b5b368;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 37;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h589f8779b025244) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 17;
    RW0_wdata = 'hb7ef941c5e00ea6d;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 39;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h1fb797fab7d6467b) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 9;
    RW0_wdata = 'h955d0e77fb5eb866;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 25;
    RW0_wdata = 'h8c69778ffd42f697;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 7;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h6f25e2a25a921187) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 19;
    RW0_wdata = 'h122411e6ba8982dd;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 21;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h2284b7a447e7f593) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 35;
    RW0_wdata = 'h7b2e1b82e89dc815;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 21;
    RW0_wdata = 'h7aa56a181fd3c017;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 27;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h73581a8146743741) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 10;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'hd71037d1b83e90ec) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 4;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h4f65d4d9259f4329) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 3;
    RW0_wdata = 'h202861c62830869;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 35;
    RW0_wdata = 'h4a31b24384dd6da6;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 37;
    RW0_wdata = 'hade6c5e9b6e355f6;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 5;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'haf19922ad9b8a714) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 22;
    RW0_wdata = 'h1e70e79933a1d1c2;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 16;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h1beb37117d41e602) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 39;
    RW0_wdata = 'h1ac902ee25777cf0;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 24;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'he07405eb215663ab) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 36;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'ha62081434fbaecc0) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 34;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'hae3b16ec9a27d858) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 21;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h7aa56a181fd3c017) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 24;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'he07405eb215663ab) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 5;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'haf19922ad9b8a714) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 2;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'hae55cdff34ab18fd) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 9;
    RW0_wdata = 'ha7f5195cde62d43f;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 32;
    RW0_wdata = 'hfd938adc99a2ecb1;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 13;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h101fbcccded733e8) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 1;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'hd4713d60c8a70639) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 19;
    RW0_wdata = 'h91fcfe8881c16e98;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 4;
    RW0_wdata = 'hdc2151e17e56ac3d;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 26;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'hfca055362169df82) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 10;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'hd71037d1b83e90ec) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 18;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h71eacd0549a3e80e) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 2;
    RW0_wdata = 'h6af944e07b38785b;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 38;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'hf87f43fdf6062541) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 39;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h1ac902ee25777cf0) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 6;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h8f4ff31e78de5857) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 2;
    RW0_wdata = 'h9e0df45b992a34a1;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 6;
    RW0_wdata = 'h31e9ca8058bf3b9e;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 7;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h6f25e2a25a921187) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 43;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h6fa231e959acdd98) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 24;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'he07405eb215663ab) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 25;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h8c69778ffd42f697) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 2;
    RW0_wdata = 'hef2d9a38e6e4b8df;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 16;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h1beb37117d41e602) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 5;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'haf19922ad9b8a714) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 9;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'ha7f5195cde62d43f) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 26;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'hfca055362169df82) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 46;
    RW0_wdata = 'h7b6e08e6ac1ca75;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 46;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h7b6e08e6ac1ca75) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 7;
    RW0_wdata = 'hb1182d235bf80676;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 22;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h1e70e79933a1d1c2) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 13;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h101fbcccded733e8) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 18;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h71eacd0549a3e80e) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 9;
    RW0_wdata = 'h743c7e9d2fdeb035;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 22;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h1e70e79933a1d1c2) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 1;
    RW0_wdata = 'h35475c5ef76dce6e;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 30;
    RW0_wdata = 'h4ae9ee11f5fe0213;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 11;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'ha0116be5ab0c1681) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 34;
    RW0_wdata = 'h4ec985ff94b28b9d;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 9;
    RW0_wdata = 'h4a82e06a2f16fb50;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 42;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h361524c2cc0f859) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 25;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h8c69778ffd42f697) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 26;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'hfca055362169df82) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 37;
    RW0_wdata = 'h15a5712c5ac4b6c7;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 40;
    RW0_wdata = 'hecfb95b877a2133;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 0;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'h6baa9455e3e70682) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 23;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'ha7c5cb879b8b71a1) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 0;
    RW0_addr = 11;
    #10;
    RW0_en = 0;
    if (RW0_rdata != 'ha0116be5ab0c1681) begin
      $display("ASSERTION FAILED");
      $finish;
    end
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 35;
    RW0_wdata = 'hb02de52c9b050db2;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 25;
    RW0_wdata = 'hc4841a8d2f751bde;
    #10;
    RW0_en = 0;
    #10;
    RW0_en = 1;
    RW0_wmode = 1;
    RW0_addr = 11;
    RW0_wdata = 'hf5a3e8933f7a2748;
    #10;
    RW0_en = 0;
    $finish;
  end
  always #5 RW0_clk = ~RW0_clk;
  mem_1rw inst (
    .RW0_addr(RW0_addr),
    .RW0_en(RW0_en),
    .RW0_clk(RW0_clk),
    .RW0_wmode(RW0_wmode),
    .RW0_wdata(RW0_wdata),
    .RW0_rdata(RW0_rdata)
  );
endmodule

