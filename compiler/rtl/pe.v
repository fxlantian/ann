////////////////////////////////////////////////////////////////////////////////////
// File Name: pe.v
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

module new_pe#(
    parameter PE_ID = 0,
    parameter WEIGHT_INIT = "w0_init.mif",
    parameter BIAS_MIF = "offset_init.mif"
    )
    (
    input                   CLK,
    input                   RST_N,
    input [PECMD_WIDTH-1:0] cmd,
    input                   cmd_valid,
    input [DATA_WIDTH-1:0]  din,
    input [ACC_WIDTH-1:0]   acc_in,
    output                  acc_in_deq,
    output [ACC_WIDTH-1:0]  acc_out,
    output [ACC_WIDTH-1:0]  dout,
    output [PECMD_DST_WIDTH-1:0] dout_dst,
    output                  dout_valid,
    output                  dout_accfifo_enq,
    output                  dout_accfifo_rdy,
    // ram-specific ports
    input [RAMDATA_W-1:0] ram_din,
    input [REGSEL_W-1:0]  ram_reg_adr,
    input [MEMSEL_W-1:0]  ram_mem_adr,
    input                 ram_we
    );

    `include "params.inc"

    // FSM states
    localparam PE_IDLE           = 0;
    localparam PE_COMPUTE        = 1;
    localparam PE_FINISH         = 2;
    localparam PE_TRANSITION     = 3;

    // PE Internal state register
    `REG(fsm_state,             fsm_state_d,            reg, 4,                  PE_IDLE )
    `REG(pe_cycles,             pe_cycles_d,            reg, PECMD_MADD_WIDTH,   0       )
    `REG(pe_last_layer,         pe_last_layer_d,        reg, PECMD_LST_WIDTH,    0       )
    `REG(pe_dst,                pe_dst_d,               reg, PECMD_DST_WIDTH,    0       )
    `REG(pe_dst_dly1,           pe_dst_dly1_d,          reg, PECMD_DST_WIDTH,    0       )
    `REG(pe_dst_dly2,           pe_dst_dly2_d,          reg, PECMD_DST_WIDTH,    0       )
    `REG(pe_dst_dly3,           pe_dst_dly3_d,          reg, PECMD_DST_WIDTH,    0       )
    `REG(pe_acc_sel,            pe_acc_sel_d,           reg, PECMD_ACCSEL_WIDTH, 0       )
    `REG(pe_outvalid,           pe_outvalid_d,          reg, 4,                  0       )
    // DSP inputs
    `REG(dsp_en,                dsp_en_d,               reg, 1,                  1'b0    )
    `REG(dsp_clr,               dsp_clr_d,              reg, 1,                  1'b0    )
    `REG(dsp_din,               dsp_din_d,              reg, DATA_WIDTH,         0       )
    `REG(dsp_acc,               dsp_acc_d,              reg, ACC_WIDTH,          0       )
    // BRAM inputs
    `REG(addr,                  addr_d,                 reg, WEIGHT_ADDR_W,      0       )
    // BRAM output
    `REG(dsp_w,                 dsp_w_d,                reg, WEIGHT_WIDTH,       0       )
    `REG(bias,                  bias_d,                 reg, WEIGHT_WIDTH,       0       )
    // Output registers
    `REG(dout_valid_r,          dout_valid_r_d,         reg, 1,                  0       )
    `REG(dout_dst_r,            dout_dst_r_d,           reg, PECMD_DST_WIDTH,    0       )
    `REG(dout_accfifo_enq_r,    dout_accfifo_enq_r_d,   reg, 1,                  0       )
    `REG(dout_accfifo_rdy_r,    dout_accfifo_rdy_r_d,   reg, 1,                  0       )


    // CMD decoded signals
    wire [PECMD_ACCSEL_WIDTH-1:0]   cmd_rd_accin;
    wire [PECMD_PEID_WIDTH-1:0]     cmd_pe;
    wire [PECMD_MADD_WIDTH-1:0]     cmd_cycles;
    wire [PECMD_DST_WIDTH-1:0]      cmd_dstsel;
    wire [PECMD_LST_WIDTH-1:0]      cmd_lastl;
    // PE Accumulator MUX
    wire [ACC_WIDTH-1:0]            pe_accin_mux;
    // Start signal
    wire                            start;


//`ifdef READ_WRITE_MEMORY
    // ===============
    // Weight RAM
    // ===============
    wire [MEMSEL_W-1:0]         mem_adr = ram_mem_adr;
    reg  [REGSEL_W-1:0]         weight_reg_adr;
    wire [WEIGHT_WIDTH-1:0]     weight_cache_dout;
    // ram address mux
    always @(*) begin
        if (ram_we) weight_reg_adr = ram_reg_adr[WEIGHT_ADDR_W-1:0];
        else        weight_reg_adr = addr_d;
    end
    // ram instantiation
    ram #(
        .WIDTH(WEIGHT_WIDTH),
        .DEPTH(WEIGHT_RAM_DEPTH),
        .MEMSEL_W(MEMSEL_W),
        .REGSEL_W(REGSEL_W),
        .MEM_ADDR(WEIGHT_RAM_ADR+PE_ID)
    ) weight_ram (
        .clk(CLK),
        .mem_adr(mem_adr),
        .reg_adr(weight_reg_adr),
        .din(ram_din[WEIGHT_WIDTH-1:0]),
        .we(ram_we),
        .dout(weight_cache_dout)
    );

    // ===============
    // Bias RAM
    // ===============
    reg  [REGSEL_W-1:0]         bias_reg_adr;
    wire [WEIGHT_WIDTH-1:0]     bias_cache_dout;
    // ram address mux
    always @(*) begin
        if (ram_we) bias_reg_adr = ram_reg_adr;
        else        bias_reg_adr = addr_d;
    end
    // ram instantiation
    ram #(
        .WIDTH(WEIGHT_WIDTH),
        .DEPTH(WEIGHT_RAM_DEPTH),
        .MEMSEL_W(MEMSEL_W),
        .REGSEL_W(REGSEL_W),
        .MEM_ADDR(BIAS_RAM_ADR)
    ) bias_ram (
        .clk(CLK),
        .mem_adr(mem_adr),
        .reg_adr(bias_reg_adr),
        .din(ram_din[WEIGHT_WIDTH-1:0]),
        .we(ram_we),
        .dout(bias_cache_dout)
    );
// `else
//     // Weight RAM (read only)
//     reg [WEIGHT_WIDTH-1:0] weight_cache_dout;
//     reg [WEIGHT_WIDTH-1:0] weight_cache [WEIGHT_RAM_DEPTH-1:0];
//     // Weight mif filename string
//     reg [128*8:0] mif_file;
//     // RAM initialization
//     initial begin
//         $sformat(mif_file, "%s%02d.mif", WEIGHT_INIT, PE_ID);
//         $readmemh(mif_file, weight_cache, 0, WEIGHT_RAM_DEPTH-1);
//     end
//
//     // Bias RAM (read only)
//     reg [WEIGHT_WIDTH-1:0] bias_cache_dout;
//     reg [WEIGHT_WIDTH-1:0] bias_cache [WEIGHT_RAM_DEPTH-1:0];
//     // RAM initialization
//     initial begin
//         $readmemh(BIAS_MIF, bias_cache, 0, WEIGHT_RAM_DEPTH-1);
//     end
//
//     always @(posedge CLK) begin
//         if (RST_N == 1'b0) begin
//             weight_cache_dout <= 0;
//             bias_cache_dout <= 0;
//         end else begin
//             weight_cache_dout <= weight_cache[addr_d];
//             bias_cache_dout <= bias_cache[addr_d];
//         end
//     end
// `endif

    // DSP instantiation
    generate
    if (PE_ID==0) begin
        madd_generic dsp_O(.clk(CLK),
                       .ce(dsp_en),
                       // .sclr(dsp_clr), // commented out to minimize power dissipation
                       .sclr(1'b0),
                       .a(dsp_din),
                       .b(dsp_w),
                       .c(dsp_acc),
                       .p(dout),
                       .subtract(1'b0),
                       .pcout(acc_out));
     end else begin
        madd_ch_generic dsp_C(.clk(CLK),
                             .ce(dsp_en),
                             // .sclr(dsp_clr), // commented out to minimize power dissipation
                             .sclr(1'b0),
                             .a(dsp_din),
                             .b(dsp_w),
                             .p(dout),
                             .pcin(acc_in),
                             .subtract(1'b0),
                             .pcout(acc_out));
    end
    endgenerate


    // PE accumulator MUX
    assign pe_accin_mux     = (pe_acc_sel == 1'b1) ? acc_in : {{(ACC_WIDTH-WEIGHT_WIDTH-DATA_DEC_WIDTH){bias[WEIGHT_WIDTH-1]}},bias,{(DATA_DEC_WIDTH){1'b0}}};
    // Decode CMD bus
    assign cmd_accinsel     = cmd[PECMD_ACCSEL_IDX+PECMD_ACCSEL_WIDTH-1:PECMD_ACCSEL_IDX];
    assign cmd_pe           = (NUM_PE==1) ? 0 : cmd[PECMD_PEID_IDX+PECMD_PEID_WIDTH-1:PECMD_PEID_IDX];
    assign cmd_cycles       = cmd[PECMD_MADD_IDX+PECMD_MADD_WIDTH-1:PECMD_MADD_IDX];
    assign cmd_dstsel       = cmd[PECMD_DST_IDX+PECMD_DST_WIDTH-1:PECMD_DST_IDX];
    assign cmd_lastl        = cmd[PECMD_LST_IDX+PECMD_LST_WIDTH-1:PECMD_LST_IDX];

    // Output assignments
    assign dout_valid       = dout_valid_r;
    assign dout_dst         = dout_dst_r;
    assign dout_accfifo_enq = (PE_ID == MAX_ID) ? dout_accfifo_enq_r : 1'bz;
    assign dout_accfifo_rdy = (PE_ID == MAX_ID) ? dout_accfifo_rdy_r : 1'bz;
    assign acc_in_deq       = (PE_ID == 0) ? pe_acc_sel && |(pe_cycles) : 1'bz;

    // Start decoding logic
    assign start            = (cmd_valid & (cmd_pe === PE_ID));

    // Output registers logic
    always@(*) begin
        dout_valid_r_d          = pe_outvalid[2] & |pe_dst_dly2;
        dout_dst_r_d            = pe_dst_dly2;
        dout_accfifo_enq_r_d    = ((PE_ID == MAX_ID)&&(pe_dst_dly2==IM_DSTSEL_NONE)) ? pe_outvalid[2] : 1'b0;
        dout_accfifo_rdy_r_d    = ((PE_ID == MAX_ID)&&(pe_dst_dly3==IM_DSTSEL_NONE)) ? pe_outvalid[3] : 1'b0;
    end


    // Main FSM
    always@(*) begin

        fsm_state_d         = fsm_state;

        pe_cycles_d         = pe_cycles;
        pe_last_layer_d     = pe_last_layer;
        pe_dst_d            = pe_dst;
        pe_dst_dly1_d       = pe_dst;
        pe_dst_dly2_d       = pe_dst_dly1;
        pe_dst_dly3_d       = pe_dst_dly2;
        pe_acc_sel_d        = pe_acc_sel;

        dsp_en_d            = 1'b0;
        dsp_clr_d           = 1'b1;
        dsp_din_d           = dsp_din;
        dsp_acc_d           = dsp_acc;

        dsp_w_d             = dsp_w;
        bias_d              = bias;
        addr_d              = addr;

        pe_outvalid_d[0]    = 1'b0;
        pe_outvalid_d[3:1]  = pe_outvalid[2:0];

        if(RST_N) begin
            case(fsm_state)
                PE_IDLE: begin
                    if (start == 1'b1 && |cmd_cycles == 1'b1) begin
                        pe_cycles_d         = cmd_cycles;
                        pe_last_layer_d     = cmd_lastl;
                        pe_dst_d            = cmd_dstsel;
                        pe_acc_sel_d        = cmd_accinsel;

                        dsp_en_d            = 1'b1;
                        dsp_clr_d           = 1'b0;
                        dsp_din_d           = din;
                        dsp_acc_d           = pe_accin_mux;

                        dsp_w_d             = weight_cache_dout;
                        bias_d              = bias_cache_dout;

                        if (cmd_lastl==1'b1 && cmd_cycles==8'h01) begin
                            addr_d              = 0;
                        end else begin
                            addr_d              = addr + 1;
                        end

                        pe_outvalid_d[0]    = 1'b1;

                        fsm_state_d         = PE_COMPUTE;
                    end
                end

                PE_COMPUTE: begin
                    pe_cycles_d         = pe_cycles - 1;

                    if (pe_cycles == 8'h01) begin
                        if (start == 1'b1) begin
                            pe_cycles_d         = cmd_cycles;
                            pe_last_layer_d     = cmd_lastl;
                            pe_dst_d            = cmd_dstsel;
                            pe_acc_sel_d        = cmd_accinsel;

                            dsp_en_d            = 1'b1;
                            dsp_clr_d           = 1'b0;
                            dsp_din_d           = din;
                            dsp_acc_d           = pe_accin_mux;

                            if (pe_last_layer == 1'b1) begin
                                dsp_w_d             = weight_cache_dout;
                                bias_d              = bias_cache_dout;
                                addr_d              = 1;
                            end else begin
                                dsp_w_d             = weight_cache_dout;
                                bias_d              = bias_cache_dout;
                                addr_d              = addr + 1;
                            end


                            pe_outvalid_d[0]    = 1'b1;

                            fsm_state_d         = PE_COMPUTE;
                        end else begin
                            dsp_en_d            = 1'b1;
                            dsp_clr_d           = 1'b0;
                            dsp_acc_d           = pe_accin_mux;

                            if (pe_last_layer == 1'b1) begin
                                addr_d              = 0;
                            end

                            fsm_state_d         = PE_FINISH;
                        end
                    end else if (pe_cycles == 8'h02) begin
                        if (start == 1'b1) begin
                            pe_cycles_d         = cmd_cycles;
                            pe_last_layer_d     = cmd_lastl;
                            pe_dst_d            = cmd_dstsel;
                            pe_acc_sel_d        = cmd_accinsel;
                        end

                        dsp_en_d            = 1'b1;
                        dsp_clr_d           = 1'b0;
                        dsp_acc_d           = pe_accin_mux;

                        dsp_w_d             = weight_cache_dout;
                        bias_d              = bias_cache_dout;

                        if (pe_last_layer) begin
                            addr_d              = 0;
                        end else begin
                            addr_d              = addr + 1;
                        end

                        pe_outvalid_d[0]    = 1'b1;

                        if (start == 1'b1 && pe_last_layer == 1'b1)
                            fsm_state_d         = PE_TRANSITION;
                        else
                            fsm_state_d         = PE_COMPUTE;

                    end else begin
                        dsp_en_d            = 1'b1;
                        dsp_clr_d           = 1'b0;
                        dsp_acc_d           = pe_accin_mux;

                        dsp_w_d             = weight_cache_dout;
                        bias_d              = bias_cache_dout;
                        addr_d              = addr + 1;

                        pe_outvalid_d[0]    = 1'b1;

                        fsm_state_d         = PE_COMPUTE;
                    end
                end

                PE_TRANSITION: begin
                    if (start == 1'b1) begin
                        pe_cycles_d         = cmd_cycles;
                        pe_last_layer_d     = cmd_lastl;
                        pe_dst_d            = cmd_dstsel;
                        pe_acc_sel_d        = cmd_accinsel;
                    end

                    dsp_en_d            = 1'b1;
                    dsp_clr_d           = 1'b0;
                    dsp_acc_d           = pe_accin_mux;

                    dsp_w_d             = weight_cache_dout;
                    bias_d              = bias_cache_dout;
                    addr_d              = 1;

                    pe_outvalid_d[0]    = 1'b1;

                    fsm_state_d         = PE_COMPUTE;
                end

                PE_FINISH: begin
                    if (start == 1'b1) begin
                        pe_cycles_d         = cmd_cycles;
                        pe_last_layer_d     = cmd_lastl;
                        pe_dst_d            = cmd_dstsel;
                        pe_acc_sel_d        = cmd_accinsel;

                        dsp_en_d            = 1'b1;
                        dsp_clr_d           = 1'b0;
                        dsp_din_d           = din;
                        dsp_acc_d           = pe_accin_mux;

                        dsp_w_d             = weight_cache_dout;
                        bias_d              = bias_cache_dout;
                        addr_d              = addr + 1;

                        pe_outvalid_d[0]    = 1'b1;

                        fsm_state_d         = PE_COMPUTE;
                    end else begin
                        dsp_en_d            = 1'b1;
                        dsp_clr_d           = 1'b0;

                        fsm_state_d         = PE_IDLE;
                    end
                end
            endcase
        end
    end

endmodule
