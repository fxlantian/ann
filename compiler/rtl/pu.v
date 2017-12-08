////////////////////////////////////////////////////////////////////////////////////
// File Name: pu.v
// Author: Thierry Moreau
// Email: moreau@uw.edu
//
// Copyright (c) 2012-2016 University of Washington
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
// -       Redistributions of source code must retain the above copyright notice,
//         this list of conditions and the following disclaimer.
// -       Redistributions in binary form must reproduce the above copyright notice,
//         this list of conditions and the following disclaimer in the documentation
//         and/or other materials provided with the distribution.
// -       Neither the name of the University of Washington nor the names of its
//         contributors may be used to endorse or promote products derived from this
//         software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE UNIVERSITY OF WASHINGTON AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
// IN NO EVENT SHALL THE UNIVERSITY OF WASHINGTON OR CONTRIBUTORS BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
// OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
// IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`include "macros.inc"


module new_pu
    (
    input                   CLK,
    input                   RST_N,
    input  [DATA_WIDTH-1:0] pu_din,
    input                   pu_din_valid,
    output                  pu_din_deq,
    output [DATA_WIDTH-1:0] pu_dout,
    output                  pu_dout_valid,
    // ram-specific ports
    input [RAMDATA_W-1:0] ram_din    ,
    input [REGSEL_W-1:0]  ram_reg_adr,
    input [MEMSEL_W-1:0]  ram_mem_adr,
    input                 ram_we
);


`include "params.inc"
    // Main FSM states
    localparam PU_INIT0          = 0;
    localparam PU_INIT1          = 1;
    localparam PU_IDLE           = 2;
    // Input FIFO states
    localparam IF_START          = 0;
    localparam IF_IDLE           = 1;
    localparam IF_ALMOST_EMPTY   = 2;

    // FSM State Registers
    `REG(pu_state,      pu_state_d,       reg, 4,                 PU_INIT0 )
    // Instruction memory registers
    `REG(im_addr,       im_addr_d,        reg, IM_ADDR_WIDTH,     0       )
    `REG(im_dout,       im_dout_d,        reg, IM_WIDTH,          0       )
    `REG(im_dout0,      im_dout0_d,       reg, IM_WIDTH,          0       ) // First instruction
    `REG(im_dout_dly1,  im_dout_dly1_d,   reg, IM_WIDTH,          0       )
    `REG(im_dout_dly2,  im_dout_dly2_d,   reg, IM_WIDTH,          0       )
    // Instruction memory decoded values
    `REG(im_accinsel,   im_accinsel_d,    reg, 1,                 0       ) // Acc select (derived)
    `REG(im_pe0sel,     im_pe0sel_d,      reg, 1,                 0       ) // PE0 select (derived)
    // Sigmoid inputs
    `REG(sig_in,        sig_in_d,         reg, ACC_WIDTH,         0       )
    `REG(sig_enq,       sig_enq_d,        reg, 1,                 0       )
    `REG(sig_mode,      sig_mode_d,       reg, SIGMODE_W,         0       )
    // PE inputs
    `REG(pe_din_reg,    pe_din_reg_d,     reg, DATA_WIDTH,        0       )
    `REG(pe_cmd,        pe_cmd_d,         reg, PECMD_WIDTH,       0       )
    `REG(pe_cmd_valid,  pe_cmd_valid_d,   reg, 1,                 0       )
    // PE data input mux select
    `REG(pe_din_mux_sel, pe_din_mux_sel_d, reg, IM_SRC_WIDTH,      0       )
    // Control logic related registers
    `REG(pe0_cycles,    pe0_cycles_d,     reg, IM_MADD_WIDTH,     0       )
    // Sigmoid FIFO dequeue
    `REG(sig_deq,       sig_deq_d,        reg, 1,                 1'b0    )

    // Input FIFO dequeue
    `CREG(ififo_deq,        1           )
    // Sigmoid ACK
    `CREG(sig_ack,          1           )

    // Variable for module instantiation
    genvar i;

    // PE data input
    wire [DATA_WIDTH-1:0]   pe_din;
    // PE outputs
    wire [NUM_PE-1:0]       dout_mux_sel;
    // Accumulator FIFO inputs/outputs
    wire                            accf_enq;
    wire                            accf_deq;
    wire                            accf_empty;
    // Accumulator FIFO control signals
    wire                            accf_rdy;
    // Sigmoid output
    wire [DATA_WIDTH-1:0]           sig_dout;
    wire                            sig_rdy;
    wire [DATA_WIDTH-1:0]           sig_pu_dout;
    // Accumulation chain
    wire [ACC_WIDTH*(NUM_PE+1)-1:0] pe_acc_bus;
    // Data out from PEs
    wire [ACC_WIDTH*NUM_PE-1:0]     pe_dout;
    // Data out destination from PEs
    wire [IM_DST_WIDTH*NUM_PE-1:0]  pe_dst;
    // IM decoded values
    wire [IM_MADD_WIDTH-1:0]        im_cycles;
    wire [IM_SRC_WIDTH-1:0]         im_dinsel;
    // IM derived values
    wire [PECMD_ACCSEL_IDX-1:0]     im_pe_cmd;
    wire                            im_pe0select;
    wire                            im_lastneuron;
    wire                            im_accinselect;

    wire  [20:0]    ram_din0;
    wire  [13:0]ram_reg_adr0;
    wire  [5:0] ram_mem_adr0;
    wire             ram_we0;

    wire  [20:0]    ram_din1;
    wire  [13:0]ram_reg_adr1;
    wire  [5:0] ram_mem_adr1;
    wire             ram_we1;

    wire  [20:0]    ram_din2;
    wire  [13:0]ram_reg_adr2;
    wire  [5:0] ram_mem_adr2;
    wire             ram_we2;

    wire  [20:0]    ram_din3;
    wire  [13:0]ram_reg_adr3;
    wire  [5:0] ram_mem_adr3;
    wire             ram_we3;

    wire  [20:0]    ram_din4;
    wire  [13:0]ram_reg_adr4;
    wire  [5:0] ram_mem_adr4;
    wire             ram_we4;

    wire  [20:0]    ram_din5;
    wire  [13:0]ram_reg_adr5;
    wire  [5:0] ram_mem_adr5;
    wire             ram_we5;

    wire  [20:0]    ram_din6;
    wire  [13:0]ram_reg_adr6;
    wire  [5:0] ram_mem_adr6;
    wire             ram_we6;

    wire  [20:0]    ram_din7;
    wire  [13:0]ram_reg_adr7;
    wire  [5:0] ram_mem_adr7;
    wire             ram_we7;



    // ===================
    // Instruction memory
    // ===================
    wire [MEMSEL_W-1:0]         mem_adr = ram_mem_adr;
    reg  [IM_ADDR_WIDTH-1:0]    reg_adr;
    wire [IM_WIDTH-1:0]         insn_mem_dout;
    // ram address mux
    always @(*) begin
        if (ram_we) reg_adr = ram_reg_adr[IM_ADDR_WIDTH-1:0];
        else        reg_adr = im_addr_d;
    end
    // ram instantiation
    ram #(
        .WIDTH(IM_WIDTH),
        .DEPTH(IM_RAM_DEPTH),
        .MEMSEL_W(MEMSEL_W),
        .REGSEL_W(IM_ADDR_WIDTH),
        .MEM_ADDR(IM_RAM_ADR)
    ) im_ram (
        .clk(CLK),
        .mem_adr(mem_adr),
        .reg_adr(reg_adr),
        .din(ram_din[IM_WIDTH-1:0]),
        .we(ram_we),
        .dout(insn_mem_dout)
    );

    // PE instantiations

        new_pe #(
            .PE_ID(0)
        ) pe0 (
            .CLK(CLK),
            .RST_N(RST_N),
            .cmd(pe_cmd),
            .cmd_valid(pe_cmd_valid),
            .din(pe_din),
            .acc_in(pe_acc_bus[ACC_WIDTH-1:0]),
            .acc_in_deq(accf_deq), // driven by pe_first only
            .acc_out(pe_acc_bus[ACC_WIDTH*(2)-1:ACC_WIDTH]),
            .dout(pe_dout[ACC_WIDTH-1:0]),
            .dout_dst(pe_dst[IM_DST_WIDTH-1:0]),
            .dout_valid(dout_mux_sel[0]),
            .dout_accfifo_enq(accf_enq), // driven by pe_last only
            .dout_accfifo_rdy(accf_rdy), // driven by pe_last only
            // ram-specific ports
            .ram_din    (    ram_din0),
            .ram_reg_adr(ram_reg_adr0),
            .ram_mem_adr(ram_mem_adr0),
            .ram_we     (     ram_we0)
        );

         new_pe #(
            .PE_ID(1)
        ) pe1 (
            .CLK(CLK),
            .RST_N(RST_N),
            .cmd(pe_cmd),
            .cmd_valid(pe_cmd_valid),
            .din(pe_din),
            .acc_in(pe_acc_bus[ACC_WIDTH*2-1:ACC_WIDTH]),
            .acc_in_deq(accf_deq), // driven by pe_first only
            .acc_out(pe_acc_bus[ACC_WIDTH*3-1:ACC_WIDTH*2]),
            .dout(pe_dout[ACC_WIDTH*2-1:ACC_WIDTH]),
            .dout_dst(pe_dst[IM_DST_WIDTH*(2)-1:IM_DST_WIDTH]),
            .dout_valid(dout_mux_sel[1]),
            .dout_accfifo_enq(accf_enq), // driven by pe_last only
            .dout_accfifo_rdy(accf_rdy), // driven by pe_last only
            // ram-specific ports
            .ram_din    (    ram_din1),
            .ram_reg_adr(ram_reg_adr1),
            .ram_mem_adr(ram_mem_adr1),
            .ram_we     (     ram_we1)
        );

         new_pe #(
            .PE_ID(2)
        ) pe2 (
            .CLK(CLK),
            .RST_N(RST_N),
            .cmd(pe_cmd),
            .cmd_valid(pe_cmd_valid),
            .din(pe_din),
            .acc_in(pe_acc_bus[ACC_WIDTH*(3)-1:ACC_WIDTH*2]),
            .acc_in_deq(accf_deq), // driven by pe_first only
            .acc_out(pe_acc_bus[ACC_WIDTH*(4)-1:ACC_WIDTH*(3)]),
            .dout(pe_dout[ACC_WIDTH*(3)-1:ACC_WIDTH*2]),
            .dout_dst(pe_dst[IM_DST_WIDTH*(3)-1:IM_DST_WIDTH*2]),
            .dout_valid(dout_mux_sel[2]),
            .dout_accfifo_enq(accf_enq), // driven by pe_last only
            .dout_accfifo_rdy(accf_rdy), // driven by pe_last only
            // ram-specific ports
             .ram_din    (    ram_din2),
             .ram_reg_adr(ram_reg_adr2),
             .ram_mem_adr(ram_mem_adr2),
             .ram_we     (     ram_we2)
        );

         new_pe #(
            .PE_ID(3)
        ) pe3 (
            .CLK(CLK),
            .RST_N(RST_N),
            .cmd(pe_cmd),
            .cmd_valid(pe_cmd_valid),
            .din(pe_din),
            .acc_in(pe_acc_bus[ACC_WIDTH*(4)-1:ACC_WIDTH*3]),
            .acc_in_deq(accf_deq), // driven by pe_first only
            .acc_out(pe_acc_bus[ACC_WIDTH*(5)-1:ACC_WIDTH*(4)]),
            .dout(pe_dout[ACC_WIDTH*(4)-1:ACC_WIDTH*3]),
            .dout_dst(pe_dst[IM_DST_WIDTH*(4)-1:IM_DST_WIDTH*3]),
            .dout_valid(dout_mux_sel[3]),
            .dout_accfifo_enq(accf_enq), // driven by pe_last only
            .dout_accfifo_rdy(accf_rdy), // driven by pe_last only
            // ram-specific ports
             .ram_din    (    ram_din3),
             .ram_reg_adr(ram_reg_adr3),
             .ram_mem_adr(ram_mem_adr3),
             .ram_we     (     ram_we3)
        );

         new_pe #(
            .PE_ID(4)
        ) pe4 (
            .CLK(CLK),
            .RST_N(RST_N),
            .cmd(pe_cmd),
            .cmd_valid(pe_cmd_valid),
            .din(pe_din),
            .acc_in(pe_acc_bus[ACC_WIDTH*(5)-1:ACC_WIDTH*4]),
            .acc_in_deq(accf_deq), // driven by pe_first only
            .acc_out(pe_acc_bus[ACC_WIDTH*(6)-1:ACC_WIDTH*(5)]),
            .dout(pe_dout[ACC_WIDTH*(5)-1:ACC_WIDTH*4]),
            .dout_dst(pe_dst[IM_DST_WIDTH*(5)-1:IM_DST_WIDTH*4]),
            .dout_valid(dout_mux_sel[4]),
            .dout_accfifo_enq(accf_enq), // driven by pe_last only
            .dout_accfifo_rdy(accf_rdy), // driven by pe_last only
            // ram-specific ports
              .ram_din    (    ram_din4),
              .ram_reg_adr(ram_reg_adr4),
              .ram_mem_adr(ram_mem_adr4),
              .ram_we     (     ram_we4)
        );

         new_pe #(
            .PE_ID(5)
        ) pe5 (
            .CLK(CLK),
            .RST_N(RST_N),
            .cmd(pe_cmd),
            .cmd_valid(pe_cmd_valid),
            .din(pe_din),
            .acc_in(pe_acc_bus[ACC_WIDTH*(6)-1:ACC_WIDTH*5]),
            .acc_in_deq(accf_deq), // driven by pe_first only
            .acc_out(pe_acc_bus[ACC_WIDTH*(7)-1:ACC_WIDTH*(6)]),
            .dout(pe_dout[ACC_WIDTH*(6)-1:ACC_WIDTH*5]),
            .dout_dst(pe_dst[IM_DST_WIDTH*(6)-1:IM_DST_WIDTH*5]),
            .dout_valid(dout_mux_sel[5]),
            .dout_accfifo_enq(accf_enq), // driven by pe_last only
            .dout_accfifo_rdy(accf_rdy), // driven by pe_last only
            // ram-specific ports
              .ram_din    (    ram_din5),
              .ram_reg_adr(ram_reg_adr5),
              .ram_mem_adr(ram_mem_adr5),
              .ram_we     (     ram_we5)
        );

          new_pe #(
            .PE_ID(6)
        ) pe6 (
            .CLK(CLK),
            .RST_N(RST_N),
            .cmd(pe_cmd),
            .cmd_valid(pe_cmd_valid),
            .din(pe_din),
            .acc_in(pe_acc_bus[ACC_WIDTH*(7)-1:ACC_WIDTH*6]),
            .acc_in_deq(accf_deq), // driven by pe_first only
            .acc_out(pe_acc_bus[ACC_WIDTH*(8)-1:ACC_WIDTH*(7)]),
            .dout(pe_dout[ACC_WIDTH*(7)-1:ACC_WIDTH*6]),
            .dout_dst(pe_dst[IM_DST_WIDTH*(7)-1:IM_DST_WIDTH*6]),
            .dout_valid(dout_mux_sel[6]),
            .dout_accfifo_enq(accf_enq), // driven by pe_last only
            .dout_accfifo_rdy(accf_rdy), // driven by pe_last only
            // ram-specific ports
              .ram_din    (    ram_din6),
              .ram_reg_adr(ram_reg_adr6),
              .ram_mem_adr(ram_mem_adr6),
              .ram_we     (     ram_we6)
        );

          new_pe #(
            .PE_ID(7)
        ) pe7 (
            .CLK(CLK),
            .RST_N(RST_N),
            .cmd(pe_cmd),
            .cmd_valid(pe_cmd_valid),
            .din(pe_din),
            .acc_in(pe_acc_bus[ACC_WIDTH*(8)-1:ACC_WIDTH*7]),
            .acc_in_deq(accf_deq), // driven by pe_first only
            .acc_out(pe_acc_bus[ACC_WIDTH*(9)-1:ACC_WIDTH*(8)]),
            .dout(pe_dout[ACC_WIDTH*(8)-1:ACC_WIDTH*7]),
            .dout_dst(pe_dst[IM_DST_WIDTH*(8)-1:IM_DST_WIDTH*7]),
            .dout_valid(dout_mux_sel[7]),
            .dout_accfifo_enq(accf_enq), // driven by pe_last only
            .dout_accfifo_rdy(accf_rdy), // driven by pe_last only
            // ram-specific ports
              .ram_din    (    ram_din7),
              .ram_reg_adr(ram_reg_adr7),
              .ram_mem_adr(ram_mem_adr7),
              .ram_we     (     ram_we7)
        );





    // Sigmoid instantiation
    new_sigmoid  sigmoid (
        .CLK(CLK),
        .RST_N(RST_N),
        .mode(sig_mode),
        .din(sig_in),
        .enq(sig_enq),
        .deq(sig_deq),
        .dout_ack(sig_ack),
        .dout(sig_dout),
        .dout_valid(sig_rdy),
        .pu_dout(sig_pu_dout),
        .pu_dout_valid(pu_dout_valid),
        // ram-specific ports
        .ram_din(ram_din),
        .ram_reg_adr(ram_reg_adr),
        .ram_mem_adr(ram_mem_adr),
        .ram_we(ram_we)
    );

    // Accumulator FIFO instantiation
    acc_fifo accf (
        .CLK(CLK),
        .RST_N(RST_N),
        .din(pe_dout[ACC_WIDTH*(MAX_ID+1)-1:ACC_WIDTH*MAX_ID]),
        .enq(accf_enq),
        .deq(accf_deq),
        .dout(pe_acc_bus[ACC_WIDTH-1:0]),
        .empty(accf_empty)
    );


    assign      ram_din0 =     ram_din;
    assign  ram_reg_adr0 = ram_reg_adr;
    assign  ram_mem_adr0 = ram_mem_adr;
    assign       ram_we0 =      ram_we;

    assign      ram_din1 =     ram_din;
    assign  ram_reg_adr1 = ram_reg_adr;
    assign  ram_mem_adr1 = ram_mem_adr;
    assign       ram_we1 =      ram_we;

    assign      ram_din2 =     ram_din;
    assign  ram_reg_adr2 = ram_reg_adr;
    assign  ram_mem_adr2 = ram_mem_adr;
    assign       ram_we2 =      ram_we;

    assign      ram_din3 =     ram_din;
    assign  ram_reg_adr3 = ram_reg_adr;
    assign  ram_mem_adr3 = ram_mem_adr;
    assign       ram_we3 =      ram_we;

    assign      ram_din4 =     ram_din;
    assign  ram_reg_adr4 = ram_reg_adr;
    assign  ram_mem_adr4 = ram_mem_adr;
    assign       ram_we4 =      ram_we;

    assign      ram_din5 =     ram_din;
    assign  ram_reg_adr5 = ram_reg_adr;
    assign  ram_mem_adr5 = ram_mem_adr;
    assign       ram_we5 =      ram_we;

    assign      ram_din6 =     ram_din;
    assign  ram_reg_adr6 = ram_reg_adr;
    assign  ram_mem_adr6 = ram_mem_adr;
    assign       ram_we6 =      ram_we;

    assign      ram_din7 =     ram_din;
    assign  ram_reg_adr7 = ram_reg_adr;
    assign  ram_mem_adr7 = ram_mem_adr;
    assign       ram_we7 =      ram_we;

    // Output Assignments
    assign pu_din_deq       = ififo_deq;
    assign pu_dout          = sig_pu_dout;

    // PE input MUX
    assign pe_din           = (pe_cmd_valid   == 1'b0) ? 0          :
                              (pe_din_mux_sel == 1'b0) ? pe_din_reg : sig_dout;

    // IM decoded values
    assign im_cycles        = im_dout_dly1[IM_MADD_IDX+IM_MADD_WIDTH-1:IM_MADD_IDX];
    assign im_dinsel        = im_dout_dly1[IM_SRC_IDX+IM_SRC_WIDTH-1:IM_SRC_IDX];
    assign im_pe_cmd        = im_dout_dly1[IM_PEID_IDX+LOG_PE-1:IM_LST_IDX];

    // Derived values
    assign im_pe0select     = (NUM_PE == 1) ? 1'b1 : (~(|im_dout[IM_PEID_IDX+LOG_PE-1:IM_PEID_IDX]));
    assign im_lastneuron    = im_dout[IM_LST_IDX+IM_LST_WIDTH-1:IM_LST_IDX]==IM_LAST_NEURON &&
                              ( im_dout[IM_DST_IDX+IM_DST_WIDTH-1:IM_DST_IDX]==IM_DSTSEL_OSIG0 ||
                                im_dout[IM_DST_IDX+IM_DST_WIDTH-1:IM_DST_IDX]==IM_DSTSEL_OSIG1 ||
                                im_dout[IM_DST_IDX+IM_DST_WIDTH-1:IM_DST_IDX]==IM_DSTSEL_OSIG2 );
    assign im_accinselect   = (NUM_PE == 1) ? (|im_dout[IM_PEID_IDX+IM_PEID_WIDTH-1:IM_PEID_IDX]) :
                              (~(|im_dout[IM_PEID_IDX+LOG_PE-1:IM_PEID_IDX])) &
                                (|im_dout[IM_PEID_IDX+IM_PEID_WIDTH-1:IM_PEID_IDX+LOG_PE]);

    /////////////////////////////
    // Sigmoid Input Logic
    /////////////////////////////
    wire [ACC_WIDTH-1:0]    sig_in_mux;
    wire [IM_DST_WIDTH-1:0] sig_mode_mux;
    // Register latching
    always@(*) begin
        sig_in_d            = sig_in_mux;
        sig_mode_d          = sig_mode_mux;
        sig_enq_d           = |dout_mux_sel;
    end
    // Variable width MUX
    for (i=0; i < NUM_PE; i = i + 1) begin
        assign sig_in_mux   = dout_mux_sel[i] ? pe_dout[ACC_WIDTH*(i+1)-1:ACC_WIDTH*i] : {ACC_WIDTH{1'bz}};
        assign sig_mode_mux = dout_mux_sel[i] ? pe_dst[IM_DST_WIDTH*(i+1)-1:IM_DST_WIDTH*i] : {IM_DST_WIDTH{1'bz}};
    end
    assign sig_in_mux   = dout_mux_sel==0 ? 0 : {ACC_WIDTH{1'bz}};
    assign sig_mode_mux = dout_mux_sel==0 ? 0 : {IM_DST_WIDTH{1'bz}};


    /////////////////////////////
    // PU Main FSM
    /////////////////////////////
    always@(*) begin
        // FSM State
        pu_state_d          = pu_state;

        // IM signals
        im_addr_d           = im_addr;
        im_dout0_d          = im_dout0;
        im_dout_d           = im_dout;
        im_dout_dly1_d      = im_dout_dly1;
        // Derived IM signals
        im_accinsel_d       = im_accinsel;
        im_pe0sel_d         = im_pe0sel;
        // PE bus
        pe_din_reg_d        = pu_din;
        pe_cmd_d            = 0;
        pe_cmd_valid_d      = 0;
        // PE data input mux select
        pe_din_mux_sel_d    = 0;
        // FIFO dequeue signals
        ififo_deq           = 0;
        sig_deq_d           = 0;
        // SIG ack
        sig_ack             = 0;
        // PE0 ready logic
        pe0_cycles_d        = 0;

        if (RST_N) begin
            case (pu_state)

                PU_INIT0: begin
                    pu_state_d          = PU_INIT1;
                end

                PU_INIT1: begin
                    im_addr_d           = im_addr + 1;
                    im_dout0_d          = insn_mem_dout;
                    im_dout_d           = insn_mem_dout;
                    im_dout_dly1_d      = im_dout;

                    im_accinsel_d       = im_accinselect;
                    im_pe0sel_d         = im_pe0select;

                    pu_state_d          = PU_IDLE;
                end

                PU_IDLE: begin
                    // Check if micro-op is a PE0 instruction
                    if(im_pe0sel) begin
                        // Check for NO-OP
                        if (|im_cycles == 1'b0) begin
                            im_dout_dly1_d      = im_dout;
                            im_accinsel_d       = im_accinselect;
                            im_pe0sel_d         = im_pe0select;

                            // Check if we're dealing with the last neuron
                            if (im_lastneuron) begin
                                im_addr_d           = 1;
                                im_dout_d           = im_dout0;
                            end else begin
                                im_addr_d           = im_addr + 1;
                                im_dout_d           = insn_mem_dout;
                            end
                        // Check if the ACC FIFO needs to be dequeued
                        end else if (im_accinsel&accf_rdy == 1'b1 || im_accinsel==1'b0) begin
                            if(pe0_cycles==8'h01 || pe0_cycles==8'h00) begin
                                // Input Layer
                                if (im_dinsel==IM_DINSEL_DIN && pu_din_valid==1'b1) begin
                                    pe_cmd_d[PECMD_ACCSEL_IDX]  = im_accinsel;
                                    pe_cmd_d[PECMD_PEID_IDX+PECMD_PEID_WIDTH-1:PECMD_LST_IDX] = im_pe_cmd;
                                    pe_cmd_valid_d              = 1'b1;

                                    pe0_cycles_d                = im_cycles;

                                    im_dout_dly1_d              = im_dout;
                                    im_accinsel_d               = im_accinselect;
                                    im_pe0sel_d                 = im_pe0select;

                                    // Check if we're dealing with the last neuron
                                    if (im_lastneuron) begin
                                        im_addr_d           = 1;
                                        im_dout_d           = im_dout0;
                                    end else begin
                                        im_addr_d           = im_addr + 1;
                                        im_dout_d           = insn_mem_dout;
                                    end

                                    pe_din_mux_sel_d    = 1'b0;
                                    ififo_deq           = 1'b1;
                                // input layer input fifo is empty
                                end else if(im_dinsel == IM_DINSEL_DIN && pu_din_valid == 1'b0) begin
                                    pe0_cycles_d = pe0_cycles;

                                // Hidden Layer
                                end else if (im_dinsel==IM_DINSEL_SIG && sig_rdy==1'b1) begin
                                    pe_cmd_d[PECMD_ACCSEL_IDX]  = im_accinsel;
                                    pe_cmd_d[PECMD_PEID_IDX+PECMD_PEID_WIDTH-1:PECMD_LST_IDX] = im_pe_cmd;
                                    pe_cmd_valid_d      = 1'b1;

                                    im_dout_dly1_d      = im_dout;
                                    im_accinsel_d       = im_accinselect;
                                    im_pe0sel_d         = im_pe0select;

                                    // Check if we're dealing with the last neuron
                                    if (im_lastneuron) begin
                                        im_addr_d           = 1;
                                        im_dout_d           = im_dout0;

                                    end else begin
                                        im_addr_d           = im_addr + 1;
                                        im_dout_d           = insn_mem_dout;
                                    end

                                    pe0_cycles_d        = im_cycles;

                                    pe_din_mux_sel_d    = 1'b1;
                                    sig_deq_d           = 1'b1;
                                    sig_ack             = 1'b1;
                                end else begin
                                    if (|pe0_cycles==1'b1) begin
                                        pe0_cycles_d            = pe0_cycles - 1;
                                    end
                                end
                            end else begin
                              // input layer input fifo is empty
                               if(im_dinsel == IM_DINSEL_DIN && pu_din_valid == 1'b0) begin
                                    pe0_cycles_d = pe0_cycles;
                               end else  if (|pe0_cycles==1'b1) begin
                                    pe0_cycles_d        = pe0_cycles - 1;
                               end
                            end
                        end else begin
                            // input layer input fifo is empty
                            if(im_dinsel == IM_DINSEL_DIN && pu_din_valid == 1'b0) begin
                                pe0_cycles_d = pe0_cycles;
                            end else if (|pe0_cycles==1'b1) begin
                                pe0_cycles_d        = pe0_cycles - 1;
                            end
                        end
                    end else begin
                        //Input layer
                        if(im_dinsel == IM_DINSEL_DIN && pu_din_valid == 1'b1) begin
                            pe_cmd_d[PECMD_ACCSEL_IDX]  = im_accinsel;
                            pe_cmd_d[PECMD_PEID_IDX+PECMD_PEID_WIDTH-1:PECMD_LST_IDX] = im_pe_cmd;
                            pe_cmd_valid_d      = 1'b1;

                            im_dout_dly1_d = im_dout;
                            im_accinsel_d  = im_accinselect;
                            im_pe0sel_d    = im_pe0select;

                            //check if we're dealing with the last neuron
                            if(im_lastneuron) begin
                                im_addr_d = 1;
                                im_dout_d = im_dout0;
                            end else begin
                                im_addr_d = im_addr + 1;
                                im_dout_d = insn_mem_dout;
                            end

                            pe_din_mux_sel_d = 1'b0;
                            ififo_deq    = 1'b1;

                            if(|pe0_cycles==1'b1) begin
                                pe0_cycles_d = pe0_cycles -1;
                            end
                        // input layer input fifo is empty
                        end else if(im_dinsel == IM_DINSEL_DIN && pu_din_valid == 1'b0) begin
                            pe0_cycles_d = pe0_cycles;
                        //hidden layer
                        end else if(im_dinsel == IM_DINSEL_SIG && sig_rdy == 1'b1) begin
                            pe_cmd_d[PECMD_ACCSEL_IDX]  = im_accinsel;
                            pe_cmd_d[PECMD_PEID_IDX+PECMD_PEID_WIDTH-1:PECMD_LST_IDX] = im_pe_cmd;
                            pe_cmd_valid_d      = 1'b1;

                            im_dout_dly1_d = im_dout;
                            im_accinsel_d  = im_accinselect;
                            im_pe0sel_d    = im_pe0select;

                            //check if we're dealing with the last neuron
                            if(im_lastneuron) begin
                                im_addr_d = 1;
                                im_dout_d = im_dout0;
                            end else begin
                                im_addr_d = im_addr + 1;
                                im_dout_d = insn_mem_dout;
                            end

                            pe0_cycles_d = im_cycles;

                            pe_din_mux_sel_d = 1'b1;
                            sig_deq_d        = 1'b1;
                            sig_ack          = 1'b1;

                            if(|pe0_cycles == 1'b1) begin
                                pe0_cycles_d = pe0_cycles - 1;
                            end
                          end
                        /*
                        pe_cmd_d[PECMD_ACCSEL_IDX]  = im_accinsel;
                        pe_cmd_d[PECMD_PEID_IDX+PECMD_PEID_WIDTH-1:PECMD_LST_IDX] = im_pe_cmd;
                        pe_cmd_valid_d      = 1'b1;

                        im_dout_dly1_d      = im_dout;
                        im_accinsel_d       = im_accinselect;
                        im_pe0sel_d         = im_pe0select;

                        // Check if we're dealing with the last neuron
                        if (im_lastneuron) begin
                            im_addr_d           = 1;
                            im_dout_d           = im_dout0;
                        end else begin
                            im_addr_d           = im_addr + 1;
                            im_dout_d           = insn_mem_dout;
                        end

                        // Input Layer
                        if (im_dinsel==IM_DINSEL_DIN) begin
                            pe_din_mux_sel_d    = 1'b0;
                            ififo_deq           = 1'b1;
                        // Hidden Layer
                        end else if (im_dinsel==IM_DINSEL_SIG) begin
                            pe_din_mux_sel_d    = 1'b1;
                            sig_deq_d           = 1'b1;
                            sig_ack             = 1'b1;
                        end

                        if (|pe0_cycles==1'b1) begin
                            pe0_cycles_d        = pe0_cycles - 1;
                          end*/
                    end
                end
            endcase
        end
    end

endmodule
