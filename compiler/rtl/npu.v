////////////////////////////////////////////////////////////////////////////////////
// File Name: npu.v
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

module new_npu#(
    parameter SIG_INIT      = "mif/sigmoid.mif",
    parameter INSN_MEM_MIF  = "mif/inversek2j_new.mif",
    parameter BIAS_MIF      = "mif/inversek2j_offset.mif",
    parameter WEIGHT_MIF    = "mif/inversek2j_w"
    )
    (
    CLK,
    RST_N,
    npu_din,
    npu_enq,
    npu_deq,
    npu_dout,
    npu_dout_valid,
    npu_full,
    input_count,
    output_count,
    // ram-specific ports
    ram_din,
    ram_reg_adr,
    ram_mem_adr,
    ram_we
    );

    `include "params.inc"

    // Clock and reset
    input                           CLK;
    input                           RST_N;
    // Input
    input [IF_WIDTH-1:0]            npu_din;
    input                           npu_enq;
    input                           npu_deq;
    // ram-specific ports
    input [RAMDATA_W-1:0]           ram_din;
    input [REGSEL_W-1:0]            ram_reg_adr;
    input [MEMSEL_W-1:0]            ram_mem_adr;
    input                           ram_we;
    // Outputs
    output [IF_WIDTH-1:0]           npu_dout;
    output                          npu_dout_valid;
    output                          npu_full;
    output [IFIFO_CNT_W:0]          input_count;
    output [OFIFO_CNT_W:0]          output_count;

    // Input counter
    `REG(input_cntr,        input_cntr_d,       reg, LOG_IF_RATIO,      0           )
    // Output counter
    `REG(output_cntr,       output_cntr_d,      reg, LOG_IF_RATIO,      0           )
    // OFIFO input
    `REG(ofifo_din,         ofifo_din_d,        reg, IF_WIDTH,          0           )
    // OFIFO enq
    `REG(ofifo_enq,         ofifo_enq_d,        reg, 1,                 0           )

    // Input FIFO inputs/outputs
    wire [IF_WIDTH-1:0]     ififo_din;
    wire [IF_WIDTH-1:0]     ififo_dout;
    wire                    ififo_enq;
    wire                    ififo_empty;
    wire                    ififo_full;
    // PU inputs and outputs
    wire [DATA_WIDTH-1:0]   pu_din;
    wire                    pu_din_deq;
    wire [DATA_WIDTH-1:0]   pu_dout;
    wire                    pu_dout_valid;
    wire                    pu_full;
    // Output FIFO inputs/outputs
    wire [IF_WIDTH-1:0]     ofifo_dout;
    wire                    ofifo_deq;
    wire                    ofifo_empty;
    wire                    ofifo_full;

    // Input FIFO enqueue
    assign ififo_din        = npu_din;
    assign ififo_enq        = npu_enq;
    assign ififo_deq        = pu_din_deq==1'b1 && input_cntr==(IF_RATIO-1);

    // Output FIFO dequeue
    assign ofifo_deq        = npu_deq;

    // Output logic
    assign npu_dout         = ofifo_dout;
    assign npu_dout_valid   = ~ofifo_empty;
    assign npu_full         = (input_count >  (IFIFO_DEPTH-8)) || (output_count > (OFIFO_DEPTH-8));

    // PU data is valid when there is data in IFIFO
    assign pu_din_valid = ~ififo_empty;

    // PU input deserialization logic
    genvar i;
    for (i=0; i < IF_RATIO; i = i + 1) begin
        assign pu_din = input_cntr==i ? ififo_dout[DATA_WIDTH*(i+1)-1:DATA_WIDTH*i] : {DATA_WIDTH{1'bz}};
    end

    // Output FIFO serialization logic
    for (i=0; i < IF_RATIO; i = i + 1) begin
        always@(*) begin
            if (RST_N && output_cntr==i && pu_dout_valid==1'b1) begin
                ofifo_din_d[DATA_WIDTH*(i+1)-1:DATA_WIDTH*i] = pu_dout;
            end else begin
                ofifo_din_d[DATA_WIDTH*(i+1)-1:DATA_WIDTH*i] = ofifo_din[DATA_WIDTH*(i+1)-1:DATA_WIDTH*i];
            end
        end
    end

    // Input and output counters for input/ouput serialization/deserialization
    always@(*) begin
        input_cntr_d        = input_cntr;
        output_cntr_d       = output_cntr;
        if (RST_N) begin
            if (pu_din_deq == 1'b1) begin
                input_cntr_d        = input_cntr + 1;
            end
            if (pu_dout_valid==1'b1) begin
                output_cntr_d       = output_cntr + 1;
            end
        end
    end

    // Output FIFO enq logic
    always@(*) begin
        ofifo_enq_d         = 1'b0;
        if (RST_N) begin
            if (pu_dout_valid == 1'b1 && output_cntr==(IF_RATIO-1)) begin
                ofifo_enq_d         = 1'b1;
            end
        end
    end

    // Processing Unit
    new_pu #(
        .SIG_INIT(SIG_INIT),
        .INSN_MEM_MIF(INSN_MEM_MIF),
        .BIAS_MIF(BIAS_MIF),
        .WEIGHT_MIF(WEIGHT_MIF)
    ) pu (
        .CLK(CLK),
        .RST_N(RST_N),
        .pu_din(pu_din),
        .pu_din_valid(pu_din_valid),
        .pu_din_deq(pu_din_deq),
        .pu_dout(pu_dout),
        .pu_dout_valid(pu_dout_valid),
        // ram-specific ports
        .ram_din(ram_din),
        .ram_reg_adr(ram_reg_adr),
        .ram_mem_adr(ram_mem_adr),
        .ram_we(ram_we)
    );

    fifo_fwf_input #(
        .WIDTH(IF_WIDTH),
        .DEPTH(IFIFO_DEPTH),
        .AW(IFIFO_CNT_W)
    ) input_fifo (
        .clk(CLK),
        .srst(~RST_N),
        .wr_en(ififo_enq),
        .rd_en(ififo_deq),
        .din(ififo_din),
        .dout(ififo_dout),
        .empty(ififo_empty),
        .full(ififo_full),
        .data_count(input_count)
    );

    fifo_fwf #(
        .WIDTH(IF_WIDTH),
        .DEPTH(OFIFO_DEPTH),
        .AW(OFIFO_CNT_W)
    ) output_fifo (
        .clk(CLK),
        .srst(~RST_N),
        .wr_en(ofifo_enq),
        .rd_en(ofifo_deq),
        .din(ofifo_din),
        .dout(ofifo_dout),
        .empty(ofifo_empty),
        .full(ofifo_full),
        .data_count(output_count)
    );

endmodule
