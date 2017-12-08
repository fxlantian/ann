////////////////////////////////////////////////////////////////////////////////////
// File Name: madd_generic.v
// Author: Sung Min Kim
// Email: sungk9@uw.edu
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

module madd_generic
(
    input                               clk,
    input                               ce,
    input                               sclr,
    input                               subtract,
    input  signed [DATA_WIDTH-1:0]      a,
    input  signed [WEIGHT_WIDTH-1:0]    b,
    input  signed [ACC_WIDTH-1:0]       c,
    output signed [ACC_WIDTH-1:0]       p,
    output signed [ACC_WIDTH-1:0]       pcout
);

`include "params.inc"

// ==========================
//     Input Registers
// ==========================
reg signed [DATA_WIDTH-1:0] a_reg;
reg signed [WEIGHT_WIDTH-1:0] b_reg;
reg signed [ACC_WIDTH-1:0] c_reg;
reg sub_reg;

always @(posedge clk or posedge sclr) begin
    if (sclr) begin
        a_reg <= 0;
        b_reg <= 0;
        c_reg <= 0;
        sub_reg <= 1'b0;
    end else begin
        a_reg <= a;
        b_reg <= b;
        c_reg <= c;
        sub_reg <= subtract;
    end
end

// ====================
//     Multiply-Adder
// ====================
reg signed [ACC_WIDTH-1:0] post_mult;
reg signed [ACC_WIDTH-1:0] post_acc;

always @(posedge clk or posedge sclr) begin
    if (sclr) begin
        post_mult <= 0;
        post_acc <= 0;
    end else begin
        if (ce) begin
            post_mult <= a_reg * b_reg;
            if (sub_reg)
                post_acc <= c_reg - post_mult;
            else
                post_acc <= c_reg + post_mult;
        end else begin
            post_mult <= post_mult;
            post_acc <= post_acc;
        end
    end
end

assign p = post_acc;
assign pcout = post_acc;

endmodule
