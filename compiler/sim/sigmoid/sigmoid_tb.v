`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2016/05/24 16:53:22
// Design Name:
// Module Name: sigmoid_tb
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module sigmoid_tb();

  localparam  PER = 10;
  localparam  DATA_WIDTH = 8;
  localparam  ACC_WIDTH = 26;
  localparam  RAMDATA_W = 21;
  localparam  MEMSEL_W = 6;
  localparam  REGSEL_W = 14;

  localparam IM_DSTSEL_SIG1    = 3'b010;
  localparam IM_DSTSEL_SIG2    = 3'b011;
  localparam SIGFIFO_CNT_W        = 6;
  localparam SIG_RAM_ADR = 4'b0010;

  reg  CLK;
  reg  RST_N;
  reg [2:0]  mode;
  reg [ACC_WIDTH-1:0]   din;
  reg                   enq;
  reg                   deq;
  reg                   dout_ack;
  wire [DATA_WIDTH-1:0] dout;
  wire                  dout_valid;
  wire [DATA_WIDTH-1:0] pu_dout;
  wire                  pu_dout_valid;
  // ram-specific ports
  reg [RAMDATA_W-1:0] ram_din;
  reg [REGSEL_W-1:0]  ram_reg_adr;
  reg [MEMSEL_W-1:0]  ram_mem_adr;
  reg                 ram_we;

  wire [SIGFIFO_CNT_W-1:0] fifo_counter;
  wire [SIGFIFO_CNT_W-1:0] fifo_counter_d;
  wire output_valid;
  wire output_valid_d;
  wire [2:0] sig_en_hid_dly;
  wire [2:0] sig_en_hid_dly_d;
  wire [2:0] sig_en_out_dly_d;
  wire [2:0] sig_en_out_dly;

  wire [DATA_WIDTH-1:0] sigf_dout;
  wire [DATA_WIDTH-1:0] sigf_din;
  wire sigf_deq;
  wire sigf_enq;

  wire [DATA_WIDTH-1:0] sig_out;
  wire [ACC_WIDTH-1:0] sig_in;

  assign fifo_counter = sigmoid.fifo_counter;
  assign fifo_counter_d = sigmoid.fifo_counter_d;
  assign output_valid = sigmoid.output_valid;
  assign output_valid_d = sigmoid.output_valid_d;

  assign sig_en_hid_dly = sigmoid.sig_en_hid_dly;
  assign sig_en_hid_dly_d = sigmoid.sig_en_hid_dly_d;
  assign sig_en_out_dly = sigmoid.sig_en_out_dly;
  assign sig_en_out_dly_d = sigmoid.sig_en_out_dly_d;

  assign sigf_dout = sigmoid.sigf_dout;
  assign sigf_din = sigmoid.sigf_din;
  assign sigf_deq = sigmoid.sigf_deq;
  assign sigf_enq = sigmoid.sigf_enq;
  assign sigf_empty = sigmoid.sigf_empty;

  assign sig_out = sigmoid.sig_out;
  assign sig_in = sigmoid.sig_in;

  integer i;

  always  begin
      #(PER/2) CLK =  ~CLK;
  end

  initial begin

    $dumpfile("sigmoid_tb.vcd");
    $dumpvars;
    $dumpon;

      CLK <= 1;
      RST_N <= 0;
      mode <= 0;
      din <= 0;
      enq <= 0;
      deq <= 0;
      dout_ack <= 0;
      ram_din <= 0;
      ram_reg_adr <= 0;
      ram_mem_adr <= 0;
      ram_we <= 0;

      #(PER*2);
      RST_N <= 1;
      ram_mem_adr <= SIG_RAM_ADR;

      #(PER);
      mode <= IM_DSTSEL_SIG2;
      enq <= 1;
      deq <= 0;
      dout_ack <= 0;

      #(PER*10);
      din <= 26'h200;//26'h3FFC3FC;
      #(PER*2);
      din <= 26'h400;//26'h3FFC6FC;
      #(PER*2);
      din <= 26'h600;//26'h3FFC1FC;
      #(PER*2);
      din <= 26'h800;//26'h3EE8;
      #(PER*2);
      dout_ack = 1;
      #(PER*2);
      din <= 0;
      deq <= 1;
      enq <= 0;
      mode <= 0;


//      for(i=0;i<10;i++) begin
//          #(PER);
//          din = 26'h100+din;
//          deq =
//          dout_ack

//      end
//
  #(PER*10);
  $dumpoff;
  $finish;
  end


  // Sigmoid instantiation
  new_sigmoid  sigmoid (
      .CLK(CLK),
      .RST_N(RST_N),
      .mode(mode),
      .din(din),
      .enq(enq),
      .deq(deq),
      .dout_ack(dout_ack),
      .dout(dout),
      .dout_valid(dout_valid),
      .pu_dout(pu_dout),
      .pu_dout_valid(pu_dout_valid),
      // ram-specific ports
      .ram_din(ram_din),
      .ram_reg_adr(ram_reg_adr),
      .ram_mem_adr(ram_mem_adr),
      .ram_we(ram_we)
  );



endmodule
