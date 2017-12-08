////////////////////////////////////////////////////////////////////////////////
// File Name: sigmoid_lut_tb.v
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
`define VCD_DUMP

module sigmoid_lut_tb;

    // Include parameter file
    `include "params.inc"

    localparam SIG_INPUT_WIDTH  = ACC_WIDTH;
    localparam SIG_OUTPUT_WIDTH = DATA_WIDTH;

    // Inputs
    reg CLK;
    reg RST_N;
    reg [RAMDATA_W-1:0] ram_din;
    reg [REGSEL_W-1:0] ram_reg_adr;
    reg [MEMSEL_W-1:0] ram_mem_adr;
    reg ram_we;

    // Outputs
    wire [SIG_OUTPUT_WIDTH-1:0] data_out;

    // Simulation variables
    integer i;

    // SRAM and indices
    reg [SIG_INPUT_WIDTH-1:0] inputs [SIGTB_TEST_SIZE-1:0];
    reg [SIG_OUTPUT_WIDTH-1:0] outputs [SIGTB_TEST_SIZE-1:0];
    reg [SIG_OUTPUT_WIDTH-1:0] sigmoid [SIG_LUT_DEPTH-1:0];
    reg [SIGTB_LOG_TEST_SIZE-1:0] inDataIdx;
    reg [SIGTB_LOG_TEST_SIZE-1:0] outDataIdx;
    reg [LOG_SIG_LUT_DEPTH-1:0] sigDataIdx;

    // SRAM outputs
    wire [SIG_INPUT_WIDTH-1:0] inData = inputs[inDataIdx];
    wire [SIG_OUTPUT_WIDTH-1:0] outData = outputs[outDataIdx];
    wire [SIG_OUTPUT_WIDTH-1:0] sigData = sigmoid[sigDataIdx];

    // Instantiate the Unit Under Test (UUT)
    sigmoid_lut uut (
        .clk(CLK),
        .rst_n(RST_N),
        .mode({1'b0, SIGMODE_SYMMETRIC}),
        .din(inData),
        .dout(data_out),
        .ram_din(ram_din),
        .ram_reg_adr(ram_reg_adr),
        .ram_mem_adr(ram_mem_adr),
        .ram_we(ram_we)
    );

    // clock generation
    always begin
        #(PER/2) CLK =~ CLK;
    end

    always @ ( posedge CLK ) begin
        $display("time = %d",$time);
        $display("inData = %x",inData);
        $display("data_out = %x",data_out);
    end

    initial begin

        `ifdef VCD_DUMP
            $dumpfile("sigmoid_lut_tb.vcd");
            $dumpvars;
            $dumpon;
        `endif
        `ifdef VPD_DUMP
            $vcdplusfile("sigmoid_lut_tb.vpd");
            $vcdpluson();
        `endif

        // Initialize memory
        $readmemh("sig_input.mif", inputs);
        $readmemh("sig_output.mif", outputs);
        $readmemh("sigmoid.mif", sigmoid);

        // Initialize Inputs
        CLK = 1;
        RST_N = 0;
        ram_din = 0;
        ram_reg_adr = 0;
        ram_mem_adr = 0;
        ram_we = 0;
        sigDataIdx = 0;
        inDataIdx = 0;
        outDataIdx = 0;

        // Global reset
        #(PER)
        RST_N = 1;

        // Wait 10 periods for global reset to finish
        #(PER*10);

//`ifdef READ_WRITE_MEMORY
        $display("Loading sigmoid LUT contents");
        // Load the Sigmoid SRAM
        for (i = 0; i < SIG_LUT_DEPTH-1; i = i+1) begin
            #(PER);
            ram_we = 1;
            ram_mem_adr = SIG_RAM_ADR;
            sigDataIdx = sigDataIdx + 1;
            ram_din = sigData;
            ram_reg_adr = sigDataIdx;
        end
        #(PER)
        ram_we = 0;
//`endif

        // Start recording
        $display("Simulation start!");
        `ifdef DEBUG
            $display("\t\ttime,\tidx\tdin,\tlut_idx\tdout\tref");
            $monitor("%d,\t%d,\t%h,\t%d\t%h\t%h",$time,inDataIdx,inData,uut.lut_index,data_out,outData);
        `endif
        for (i = 0; i < SIGTB_TEST_SIZE+SIGTB_UUT_DELAY; i = i+1) begin
            #(PER);
            if (i < SIGTB_TEST_SIZE-1) begin
                inDataIdx = inDataIdx + 1;
            end
            if (i >= SIGTB_UUT_DELAY) begin
                outDataIdx = inDataIdx - SIGTB_UUT_DELAY;
            end else begin
                outDataIdx = 0;
            end
            if (data_out !== outData) begin
                $display ("ERROR at time %d", $time);
                $display ("\tExpected value %h, Got Value %h", outData, data_out);
                // $finish;
            end
        end

        #(PER*10);
        $display ("Simulation Completed! SUCCESS!!!");
        `ifdef VCD_DUMP
            $dumpoff;
        `endif
        `ifdef VPD_DUMP
            $vcdplusoff;
        `endif
        $finish;

    end

endmodule
