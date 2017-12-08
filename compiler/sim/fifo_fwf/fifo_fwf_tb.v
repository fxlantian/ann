////////////////////////////////////////////////////////////////////////////////////
// File Name: fifo_fwf_tb.v
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

module fifo_fwf_tb;

    // Simulation Parameters
    parameter PER = 100;
    // FIFO delay
    parameter SIG_DELAY = 1;
    // FIFO dimensions
    parameter DATA_WIDTH = 32;
    parameter FIFO_DEPTH = 32;

    // Inputs
    reg                 CLK;
    reg                 RST_N;
    reg [DATA_WIDTH-1:0] din;
    reg                 enq;
    reg                 deq;

    // Outputs
    wire [DATA_WIDTH-1:0]   dout;
    wire                    empty;
    wire                    full;

    // Simulation variables
    integer i;

    // Reference output
    reg [DATA_WIDTH-1:0] ref;

    fifo_fwf #(
        .WIDTH(DATA_WIDTH),
        .DEPTH(FIFO_DEPTH)
    ) uut (
       .clk(CLK),
       .srst(~RST_N),
       .wr_en(enq),
       .rd_en(deq),
       .din(din),
       .dout(dout),
       .empty(empty),
       .full(full),
       .data_count()
    );

    // clock generation
    always begin
        #(PER/2) CLK =~ CLK;
    end

    initial begin

        // Waveform dump file
        `ifdef VCD_DUMP
            $dumpfile("fifo_fwf_tb.vcd");
            $dumpvars;
            $dumpon;
        `endif
        `ifdef VPD_DUMP
            $vcdplusfile("fifo_fwf_tb.vpd");
            $vcdpluson();
        `endif

        // Initialize Inputs
        CLK = 0;
        RST_N = 0;
        din = 0;
        enq = 0;
        deq = 0;
        ref = 0;

        #(PER)
        RST_N = 1;

        // Wait 10 periods for global reset to finish
        #(PER*10);

        $display("\t\ttime,\tCLK,\t\ti,\tenq,\tdeq,\tdin,\tempty,\tfull,\tdout\tref");
        $monitor("%d,\t%b,\t%d,\t%b,\t%b,\t%h,\t%b,\t%b,\t%h,\t%h",$time,CLK,i,enq,deq,din,empty,full,dout,ref);

        // Enqueue data
        for (i = 0; i < FIFO_DEPTH+SIG_DELAY; i = i+1) begin
            #(PER)
            if (i<=SIG_DELAY) begin
                enq = 1;
                deq = 0;
                din = din+1;
            end else begin
                ref = ref+1;
                deq = 1;
                if (i>=FIFO_DEPTH) begin
                    enq = 0;
                    din = 0;
                end else begin
                    enq = 1;
                    din = din+1;
                end

                if (dout !== ref) begin
                    $display ("ERROR at time %d", $time);
                    $display ("\tExpected value %h, Got Value %h", dout, ref);
                   // $finish;
                end
            end
        end

        #(PER)
        enq = 0;
        deq = 0;
        

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
