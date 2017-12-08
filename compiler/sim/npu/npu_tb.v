////////////////////////////////////////////////////////////////////////////////
// File Name: npu_tb.v
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


`ifdef GLOBAL_PARAMS
    `include "params.inc"
`endif

module npu_tb;

    // Parameters are defined in these files
    `include "macros.inc"
    `ifndef GLOBAL_PARAMS
        `include "params.inc"
    `endif

    // Memory initialization files
    parameter SIG_INIT          = "mif/sigmoid.mif";
    parameter INSN_MEM_MIF      = "mif/meminit_insn.mif";
    parameter WEIGHT_MIF        = "mif/meminit_w";
    parameter BIAS_MIF          = "mif/meminit_offset.mif";
    parameter INPUT_VECTORS     = "mif/meminit_input_vectors.mif";
    parameter OUTPUT_VECTORS    = "mif/meminit_output_vectors.mif";

    // Simulation Variables
    integer i, j, k;
    localparam  SIG_OUTPUT_WIDTH = 8;

    // Inputs
    reg CLK;
    reg RST_N;
    reg start;
    reg npu_enq, npu_enq_d;
    reg npu_deq;
    reg [RAMDATA_W-1:0] ram_din;
    reg [MEMSEL_W-1:0]  ram_mem_adr;
    reg [REGSEL_W-1:0]  ram_reg_adr;
    reg                 ram_we;

    // Outputs
    wire [IF_WIDTH-1:0] npu_dout;
    wire npu_dout_valid;
    wire npu_full;
    wire [IFIFO_CNT_W:0] input_count;
    wire [OFIFO_CNT_W:0] output_count;

    // SRAM and indices
    reg [IF_WIDTH-1:0] inputs [(NPU_TEST_SIZE*INPUT_SIZE)-1:0];
    reg [IF_WIDTH-1:0] outputs [(NPU_TEST_SIZE*OUTPUT_SIZE)-1:0];
    reg [31:0] inDataIdx, inDataIdx_d;
    reg [31:0] outDataIdx, outDataIdx_d;
    reg [IF_WIDTH-1:0] inData, inData_d;

    // SRAM output data outputs
    wire [IF_WIDTH-1:0] outData = outputs[outDataIdx];

    // Instantiate the Unit Under Test (UUT)
    new_npu #(
        .SIG_INIT(SIG_INIT),
        .INSN_MEM_MIF(INSN_MEM_MIF),
        .BIAS_MIF(BIAS_MIF),
        .WEIGHT_MIF(WEIGHT_MIF)) uut (
        .CLK(CLK),
        .RST_N(RST_N),
        .npu_din(inData),
        .npu_enq(npu_enq),
        .npu_deq(npu_deq),
        .npu_dout(npu_dout),
        .npu_dout_valid(npu_dout_valid),
        .npu_full(npu_full),
        .input_count(input_count),
        .output_count(output_count),
        // ram-specific ports
        .ram_din(ram_din),
        .ram_reg_adr(ram_reg_adr),
        .ram_mem_adr(ram_mem_adr),
        .ram_we(ram_we)
    );

//`ifdef READ_WRITE_MEMORY
    // sigmoid ram init.
    reg [SIG_OUTPUT_WIDTH-1:0] sig_init [SIG_LUT_DEPTH-1:0];
    initial begin
        $readmemh(SIG_INIT, sig_init, 0, SIG_LUT_DEPTH-1);
    end

    // instruction mem ram init.
    reg [IM_WIDTH-1:0] im_init [IM_RAM_DEPTH-1:0];
    initial begin
        $readmemb(INSN_MEM_MIF, im_init, 0, IM_RAM_DEPTH-1);
    end

    // weight ram init.
    reg [128*8:0] mif_file;
    reg [WEIGHT_WIDTH-1:0] weight_init [WE_ADDR_SPACE-1:0];
    initial begin
        for (i = 0; i < NUM_PE; i++) begin
            $sformat(mif_file, "%s%02d.mif", WEIGHT_MIF, i);
            $readmemh(mif_file, weight_init, WEIGHT_RAM_DEPTH*i, WEIGHT_RAM_DEPTH*(i+1)-1);
        end
    end

    // bias ram init.
    reg [WEIGHT_WIDTH-1:0] bias_init [WEIGHT_RAM_DEPTH-1:0];
    initial begin
       $readmemh(BIAS_MIF, bias_init, 0, WEIGHT_RAM_DEPTH-1);
    end
//`endif

    // Clock Generation
    always begin
        #(PER/2) CLK =~ CLK;
    end

    // Registers
    always@(posedge CLK) begin
        if(RST_N) begin
            npu_enq    <= npu_enq_d;
            inData     <= inData_d;
            inDataIdx  <= inDataIdx_d;
            outDataIdx <= outDataIdx_d;
        end
        else begin
            npu_enq    <= 0;
            inData     <= 0;
            inDataIdx  <= 0;
            outDataIdx <= 0;
        end
    end

    // Input Logic
    always @(*) begin
        npu_enq_d = 0;
        inData_d = inData;
        inDataIdx_d = inDataIdx;
        if (start == 1'b1 && inDataIdx < NPU_TEST_SIZE*INPUT_SIZE && npu_full!=1'b1) begin
            npu_enq_d = 1'b1;
            inData_d = inputs[inDataIdx];
            inDataIdx_d = inDataIdx + 1;
        end
    end

    // Output Logic
    always @(*) begin
        if (npu_dout_valid == 1'b1) begin
            npu_deq = 1;
            outDataIdx_d = outDataIdx + 1;

        end else begin
            npu_deq = 0;
            outDataIdx_d = outDataIdx;
        end
    end

    // Output Validation
    always @(posedge CLK) begin
       if ((npu_dout_valid==1) && outData!==npu_dout && outData!==16'h7fff) begin
            $display ("ERROR at time %d", $time);
            $display ("    Output index: %d", outDataIdx/OUTPUT_SIZE);
            $display ("    Expected value %h, got value %h", outData, npu_dout);
            // #100;
            // $finish;
        end

        if (npu_dout_valid == 1'b1) begin
            $fdisplay(file,"%h",npu_dout);
            //$display("output value time = %t",$time);
            // $display("input fifo width = %d",uut.input_fifo.DW);
            // $display("output fifo width = %d",uut.output_fifo.DW);
        end

        if (outDataIdx == NPU_TEST_SIZE*OUTPUT_SIZE) begin
            $display ("Simulation testbench done! SUCCESS!!!");
            $display ("all has done use time = %t",$time);
            #100;
            $finish;
        end
    end

`ifdef DEBUG
    // ANN debugging
    wire signed [ACC_WIDTH-1:0] debug_din;
    wire debug_enq;
    integer idx = 0;
    assign debug_din = uut.pu.sigmoid.din;
    assign debug_enq = uut.pu.sigmoid.enq;
    always @(posedge CLK) begin
        if ((debug_enq==1)) begin
            $display ("Debug: %d %d %d %d", $time, idx/HIDDEN_NEURONS, idx%HIDDEN_NEURONS, debug_din);
            idx += 1;
        end
        // $display ("Debug: %d %h %b %d %h %b %h %d, %h", $time, uut.ififo_dout, uut.pu_din_deq, uut.input_cntr, uut.pu_din, uut.pu_dout_valid, uut.pu_dout, uut.output_cntr, uut.ofifo_din);
    end
`endif


    integer file;

    // TESTBENCH
    initial begin
        // Waveform dump file
        //`ifdef VCD_DUMP
            $dumpfile("npu_tb.vcd");
            $dumpvars;
            $dumpon;
        //`endif
        // `ifdef VPD_DUMP
        //     $vcdplusfile("npu_tb.vpd");
        //     $vcdpluson();
        // `endif

        // Initialize Inputs
        CLK = 0;
        RST_N = 0;
        ram_din = 0;
        ram_reg_adr = 0;
        ram_mem_adr = 0;
        ram_we = 0;

        // Initialize memory
        $readmemh(INPUT_VECTORS, inputs);
        $readmemh(OUTPUT_VECTORS, outputs);

        //write to file
        file = $fopen("output.txt","w");

        // Load memories
//`ifdef READ_WRITE_MEMORY
        #(PER*10);
        for (i = 0; i < 4; i = i+1) begin
            #(PER);
            ram_we = 1;
            case (i)
                0: begin // sigmoid LUT
                    $display ("Loading sigmoid LUT data!");
                    k = SIG_LUT_DEPTH;
                    ram_mem_adr = SIG_RAM_ADR;
                end
                1: begin // instruction memory
                    $display ("Loading instruction memory!");
                    k = IM_RAM_DEPTH;
                    ram_mem_adr = IM_RAM_ADR;
                end
                2: begin // weight cache
                    $display ("Loading weight cache!");
                    k = WE_ADDR_SPACE;
                    ram_mem_adr = WEIGHT_RAM_ADR;
                end
                3: begin // bias cache
                    $display ("Loading bias cache!");
                    k = WEIGHT_RAM_DEPTH;
                    ram_mem_adr = BIAS_RAM_ADR;
                end
            endcase
            for (j = 0; j < k; j = j + 1) begin
                #(PER);
                ram_reg_adr = j;
                case (i)
                    0: begin // sigmoid LUT
                        ram_din = {{(RAMDATA_W-SIG_OUTPUT_WIDTH){1'b0}}, sig_init[j]};
                    end
                    1: begin // instruction memory
                        ram_din = {{(RAMDATA_W-IM_WIDTH){1'b0}}, im_init[j]};
                    end
                    2: begin // weight cache
                        if (NUM_PE==1) begin
                            ram_mem_adr = WEIGHT_RAM_ADR;
                        end else begin
                            ram_mem_adr = WEIGHT_RAM_ADR+j[LOG_WE_ADDR_SPACE-1:LOG_WE_ADDR_SPACE-LOG_PE];
                        end
                        ram_din = {{(RAMDATA_W-WEIGHT_WIDTH){1'b0}}, weight_init[j]};
                    end
                    3: begin // bias cache
                        ram_din = {{(RAMDATA_W-WEIGHT_WIDTH){1'b0}}, bias_init[j]};
                    end
                endcase
            end
        end

        #(PER);
        ram_we = 0;
        ram_din = 0;
        ram_mem_adr = 0;
        ram_reg_adr = 0;
//`endif

        // Wait 100 ns for global reset to finish
        #(PER);
        RST_N = 1;
        #(PER*10);

        start = 1;
        $display("start run %t",$time);


        $display("first res = %h",npu_dout);
        // #(1000)
        // npu_enq_d = 1'b1;
        // inData_d = inputs[inDataIdx];
        // inDataIdx_d = inDataIdx + 1;
        // If the testbench hasn't completed by now, somthing went wrong...
        #(TIMEOUT)
        //#(1000000)
        $display ("Simulation Timeout!");
        $fclose(file);
        //`ifdef VCD_DUMP
            $dumpoff;
        //`endif
        // `ifdef VPD_DUMP
        //     $vcdplusoff;
        // `endif
        $finish;
    end

endmodule
