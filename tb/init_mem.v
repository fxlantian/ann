reg [31:0] i;
reg [31:0] j;
localparam IN_CNT0                = 32'd6144;
localparam IM_RAM_DEPTH0       = 32'd26;
localparam BIAS_RAM_DEPTH0     = 32'd24;
localparam WEIGHT_RAM_DEPTH0   = 32'd24;
localparam SIG_LUT_DEPTH0      = 32'd512;
localparam OUT_CNT0            = 32'd1024;
localparam INIT_SRC_ADDR0      = 32'h20010000;
localparam NPU_SRC_ADDR0       = 32'h20020000;
parameter SIG_INIT0          = "../../../../../tb/all_case_mif/./mif-blackscholes-in6-out1/sigmoid.mif";
parameter INSN_MEM_MIF0      = "../../../../../tb/all_case_mif/./mif-blackscholes-in6-out1/meminit_insn.mif";
parameter WEIGHT_MIF0        = "../../../../../tb/all_case_mif/./mif-blackscholes-in6-out1/meminit_w";
parameter BIAS_MIF0          = "../../../../../tb/all_case_mif/./mif-blackscholes-in6-out1/meminit_offset.mif";
parameter INPUT_VECTORS0     = "../../../../../tb/all_case_mif/./mif-blackscholes-in6-out1/meminit_input_vectors.mif";
reg [7:0] sig_init0 [SIG_LUT_DEPTH0-1:0];
initial begin
$readmemh(SIG_INIT0, sig_init0, 0, SIG_LUT_DEPTH0-1);
end
// instruction mem ram init.
reg [20:0] im_init0 [IM_RAM_DEPTH0-1:0];
initial begin
$readmemb(INSN_MEM_MIF0, im_init0, 0, IM_RAM_DEPTH0-1);
end
// weight ram init.
reg [128*8:0] mif_file0;
reg [7:0] weight_init0 [WEIGHT_RAM_DEPTH0*8-1:0];
reg [4:0] t0;
initial begin
  for (t0 = 0; t0 < 8; t0 = t0 + 1) begin
     $sformat(mif_file0, "%s%02d.mif", WEIGHT_MIF0, t0);
     $readmemh(mif_file0, weight_init0, WEIGHT_RAM_DEPTH0*t0, WEIGHT_RAM_DEPTH0*(t0+1)-1);
  end
end
// bias ram init.
reg [7:0] bias_init0 [BIAS_RAM_DEPTH0-1:0];
initial begin
  $readmemh(BIAS_MIF0, bias_init0, 0, BIAS_RAM_DEPTH0-1);
end
//input init. 
reg [63:0] input_init0 [IN_CNT0-1:0];
initial begin
  $readmemh(INPUT_VECTORS0, input_init0, 0, IN_CNT0-1);
end
initial begin
i = 0;
for (j=0;j < IM_RAM_DEPTH0*4;j=j+32'h4) begin
  backdoor_write(j+32'h20010000,{11'b0,im_init0[i][20:0]});
  i=i+1;
end
i = 0;
for (j=IM_RAM_DEPTH0*4;j < (IM_RAM_DEPTH0*4 + WEIGHT_RAM_DEPTH0*8); j=j+32'h4) begin
  backdoor_write(j+32'h20010000,{weight_init0[i+3],weight_init0[i+2],weight_init0[i+1],weight_init0[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH0*4 + WEIGHT_RAM_DEPTH0*8; j < IM_RAM_DEPTH0*4 + WEIGHT_RAM_DEPTH0*8+BIAS_RAM_DEPTH0; j=j+32'h4) begin
  backdoor_write(j+32'h20010000,{ bias_init0[i+3], bias_init0[i+2], bias_init0[i+1], bias_init0[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH0*4 + WEIGHT_RAM_DEPTH0*8 + BIAS_RAM_DEPTH0; j < IM_RAM_DEPTH0*4 + WEIGHT_RAM_DEPTH0*8 + BIAS_RAM_DEPTH0 + SIG_LUT_DEPTH0; j=j+32'h4) begin
  backdoor_write(j+32'h20010000,{ sig_init0[i+3], sig_init0[i+2], sig_init0[i+1], sig_init0[i]});
  i=i+4;
end
i = 0;
for (j=0; j < IN_CNT0*4; j=j+32'h4) begin
  backdoor_write(j+32'h20020000,input_init0[i][31:0]);
  i=i+1;
end
end
localparam IN_CNT1                = 32'd1000;
localparam IM_RAM_DEPTH1       = 32'd10;
localparam BIAS_RAM_DEPTH1     = 32'd12;
localparam WEIGHT_RAM_DEPTH1   = 32'd12;
localparam SIG_LUT_DEPTH1      = 32'd512;
localparam OUT_CNT1            = 32'd1000;
localparam INIT_SRC_ADDR1      = 32'h20030000;
localparam NPU_SRC_ADDR1       = 32'h20040000;
parameter SIG_INIT1          = "../../../../../tb/all_case_mif/./mif_inversek2j-in2-out2/sigmoid.mif";
parameter INSN_MEM_MIF1      = "../../../../../tb/all_case_mif/./mif_inversek2j-in2-out2/meminit_insn.mif";
parameter WEIGHT_MIF1        = "../../../../../tb/all_case_mif/./mif_inversek2j-in2-out2/meminit_w";
parameter BIAS_MIF1          = "../../../../../tb/all_case_mif/./mif_inversek2j-in2-out2/meminit_offset.mif";
parameter INPUT_VECTORS1     = "../../../../../tb/all_case_mif/./mif_inversek2j-in2-out2/meminit_input_vectors.mif";
reg [7:0] sig_init1 [SIG_LUT_DEPTH1-1:0];
initial begin
$readmemh(SIG_INIT1, sig_init1, 0, SIG_LUT_DEPTH1-1);
end
// instruction mem ram init.
reg [20:0] im_init1 [IM_RAM_DEPTH1-1:0];
initial begin
$readmemb(INSN_MEM_MIF1, im_init1, 0, IM_RAM_DEPTH1-1);
end
// weight ram init.
reg [128*8:0] mif_file1;
reg [7:0] weight_init1 [WEIGHT_RAM_DEPTH1*8-1:0];
reg [4:0] t1;
initial begin
  for (t1 = 0; t1 < 8; t1 = t1 + 1) begin
     $sformat(mif_file1, "%s%02d.mif", WEIGHT_MIF1, t1);
     $readmemh(mif_file1, weight_init1, WEIGHT_RAM_DEPTH1*t1, WEIGHT_RAM_DEPTH1*(t1+1)-1);
  end
end
// bias ram init.
reg [7:0] bias_init1 [BIAS_RAM_DEPTH1-1:0];
initial begin
  $readmemh(BIAS_MIF1, bias_init1, 0, BIAS_RAM_DEPTH1-1);
end
//input init. 
reg [63:0] input_init1 [IN_CNT1-1:0];
initial begin
  $readmemh(INPUT_VECTORS1, input_init1, 0, IN_CNT1-1);
end
initial begin
i = 0;
for (j=0;j < IM_RAM_DEPTH1*4;j=j+32'h4) begin
  backdoor_write(j+32'h20030000,{11'b0,im_init1[i][20:0]});
  i=i+1;
end
i = 0;
for (j=IM_RAM_DEPTH1*4;j < (IM_RAM_DEPTH1*4 + WEIGHT_RAM_DEPTH1*8); j=j+32'h4) begin
  backdoor_write(j+32'h20030000,{weight_init1[i+3],weight_init1[i+2],weight_init1[i+1],weight_init1[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH1*4 + WEIGHT_RAM_DEPTH1*8; j < IM_RAM_DEPTH1*4 + WEIGHT_RAM_DEPTH1*8+BIAS_RAM_DEPTH1; j=j+32'h4) begin
  backdoor_write(j+32'h20030000,{ bias_init1[i+3], bias_init1[i+2], bias_init1[i+1], bias_init1[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH1*4 + WEIGHT_RAM_DEPTH1*8 + BIAS_RAM_DEPTH1; j < IM_RAM_DEPTH1*4 + WEIGHT_RAM_DEPTH1*8 + BIAS_RAM_DEPTH1 + SIG_LUT_DEPTH1; j=j+32'h4) begin
  backdoor_write(j+32'h20030000,{ sig_init1[i+3], sig_init1[i+2], sig_init1[i+1], sig_init1[i]});
  i=i+4;
end
i = 0;
for (j=0; j < IN_CNT1*4; j=j+32'h4) begin
  backdoor_write(j+32'h20040000,input_init1[i][31:0]);
  i=i+1;
end
end
localparam IN_CNT2                = 32'd42132;
localparam IM_RAM_DEPTH2       = 32'd17;
localparam BIAS_RAM_DEPTH2     = 32'd20;
localparam WEIGHT_RAM_DEPTH2   = 32'd20;
localparam SIG_LUT_DEPTH2      = 32'd512;
localparam OUT_CNT2            = 32'd4681;
localparam INIT_SRC_ADDR2      = 32'h20050000;
localparam NPU_SRC_ADDR2       = 32'h20060000;
parameter SIG_INIT2          = "../../../../../tb/all_case_mif/./mif_sobel-in9-out1/sigmoid.mif";
parameter INSN_MEM_MIF2      = "../../../../../tb/all_case_mif/./mif_sobel-in9-out1/meminit_insn.mif";
parameter WEIGHT_MIF2        = "../../../../../tb/all_case_mif/./mif_sobel-in9-out1/meminit_w";
parameter BIAS_MIF2          = "../../../../../tb/all_case_mif/./mif_sobel-in9-out1/meminit_offset.mif";
parameter INPUT_VECTORS2     = "../../../../../tb/all_case_mif/./mif_sobel-in9-out1/meminit_input_vectors.mif";
reg [7:0] sig_init2 [SIG_LUT_DEPTH2-1:0];
initial begin
$readmemh(SIG_INIT2, sig_init2, 0, SIG_LUT_DEPTH2-1);
end
// instruction mem ram init.
reg [20:0] im_init2 [IM_RAM_DEPTH2-1:0];
initial begin
$readmemb(INSN_MEM_MIF2, im_init2, 0, IM_RAM_DEPTH2-1);
end
// weight ram init.
reg [128*8:0] mif_file2;
reg [7:0] weight_init2 [WEIGHT_RAM_DEPTH2*8-1:0];
reg [4:0] t2;
initial begin
  for (t2 = 0; t2 < 8; t2 = t2 + 1) begin
     $sformat(mif_file2, "%s%02d.mif", WEIGHT_MIF2, t2);
     $readmemh(mif_file2, weight_init2, WEIGHT_RAM_DEPTH2*t2, WEIGHT_RAM_DEPTH2*(t2+1)-1);
  end
end
// bias ram init.
reg [7:0] bias_init2 [BIAS_RAM_DEPTH2-1:0];
initial begin
  $readmemh(BIAS_MIF2, bias_init2, 0, BIAS_RAM_DEPTH2-1);
end
//input init. 
reg [63:0] input_init2 [IN_CNT2-1:0];
initial begin
  $readmemh(INPUT_VECTORS2, input_init2, 0, IN_CNT2-1);
end
initial begin
i = 0;
for (j=0;j < IM_RAM_DEPTH2*4;j=j+32'h4) begin
  backdoor_write(j+32'h20050000,{11'b0,im_init2[i][20:0]});
  i=i+1;
end
i = 0;
for (j=IM_RAM_DEPTH2*4;j < (IM_RAM_DEPTH2*4 + WEIGHT_RAM_DEPTH2*8); j=j+32'h4) begin
  backdoor_write(j+32'h20050000,{weight_init2[i+3],weight_init2[i+2],weight_init2[i+1],weight_init2[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH2*4 + WEIGHT_RAM_DEPTH2*8; j < IM_RAM_DEPTH2*4 + WEIGHT_RAM_DEPTH2*8+BIAS_RAM_DEPTH2; j=j+32'h4) begin
  backdoor_write(j+32'h20050000,{ bias_init2[i+3], bias_init2[i+2], bias_init2[i+1], bias_init2[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH2*4 + WEIGHT_RAM_DEPTH2*8 + BIAS_RAM_DEPTH2; j < IM_RAM_DEPTH2*4 + WEIGHT_RAM_DEPTH2*8 + BIAS_RAM_DEPTH2 + SIG_LUT_DEPTH2; j=j+32'h4) begin
  backdoor_write(j+32'h20050000,{ sig_init2[i+3], sig_init2[i+2], sig_init2[i+1], sig_init2[i]});
  i=i+4;
end
i = 0;
for (j=0; j < IN_CNT2*4; j=j+32'h4) begin
  backdoor_write(j+32'h20060000,input_init2[i][31:0]);
  i=i+1;
end
end
localparam IN_CNT3                = 32'd1144;
localparam IM_RAM_DEPTH3       = 32'd10;
localparam BIAS_RAM_DEPTH3     = 32'd12;
localparam WEIGHT_RAM_DEPTH3   = 32'd12;
localparam SIG_LUT_DEPTH3      = 32'd512;
localparam OUT_CNT3            = 32'd2288;
localparam INIT_SRC_ADDR3      = 32'h20090000;
localparam NPU_SRC_ADDR3       = 32'h200a0000;
parameter SIG_INIT3          = "../../../../../tb/all_case_mif/./mif_fft-in1-out2/sigmoid.mif";
parameter INSN_MEM_MIF3      = "../../../../../tb/all_case_mif/./mif_fft-in1-out2/meminit_insn.mif";
parameter WEIGHT_MIF3        = "../../../../../tb/all_case_mif/./mif_fft-in1-out2/meminit_w";
parameter BIAS_MIF3          = "../../../../../tb/all_case_mif/./mif_fft-in1-out2/meminit_offset.mif";
parameter INPUT_VECTORS3     = "../../../../../tb/all_case_mif/./mif_fft-in1-out2/meminit_input_vectors.mif";
reg [7:0] sig_init3 [SIG_LUT_DEPTH3-1:0];
initial begin
$readmemh(SIG_INIT3, sig_init3, 0, SIG_LUT_DEPTH3-1);
end
// instruction mem ram init.
reg [20:0] im_init3 [IM_RAM_DEPTH3-1:0];
initial begin
$readmemb(INSN_MEM_MIF3, im_init3, 0, IM_RAM_DEPTH3-1);
end
// weight ram init.
reg [128*8:0] mif_file3;
reg [7:0] weight_init3 [WEIGHT_RAM_DEPTH3*8-1:0];
reg [4:0] t3;
initial begin
  for (t3 = 0; t3 < 8; t3 = t3 + 1) begin
     $sformat(mif_file3, "%s%02d.mif", WEIGHT_MIF3, t3);
     $readmemh(mif_file3, weight_init3, WEIGHT_RAM_DEPTH3*t3, WEIGHT_RAM_DEPTH3*(t3+1)-1);
  end
end
// bias ram init.
reg [7:0] bias_init3 [BIAS_RAM_DEPTH3-1:0];
initial begin
  $readmemh(BIAS_MIF3, bias_init3, 0, BIAS_RAM_DEPTH3-1);
end
//input init. 
reg [63:0] input_init3 [IN_CNT3-1:0];
initial begin
  $readmemh(INPUT_VECTORS3, input_init3, 0, IN_CNT3-1);
end
initial begin
i = 0;
for (j=0;j < IM_RAM_DEPTH3*4;j=j+32'h4) begin
  backdoor_write(j+32'h20090000,{11'b0,im_init3[i][20:0]});
  i=i+1;
end
i = 0;
for (j=IM_RAM_DEPTH3*4;j < (IM_RAM_DEPTH3*4 + WEIGHT_RAM_DEPTH3*8); j=j+32'h4) begin
  backdoor_write(j+32'h20090000,{weight_init3[i+3],weight_init3[i+2],weight_init3[i+1],weight_init3[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH3*4 + WEIGHT_RAM_DEPTH3*8; j < IM_RAM_DEPTH3*4 + WEIGHT_RAM_DEPTH3*8+BIAS_RAM_DEPTH3; j=j+32'h4) begin
  backdoor_write(j+32'h20090000,{ bias_init3[i+3], bias_init3[i+2], bias_init3[i+1], bias_init3[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH3*4 + WEIGHT_RAM_DEPTH3*8 + BIAS_RAM_DEPTH3; j < IM_RAM_DEPTH3*4 + WEIGHT_RAM_DEPTH3*8 + BIAS_RAM_DEPTH3 + SIG_LUT_DEPTH3; j=j+32'h4) begin
  backdoor_write(j+32'h20090000,{ sig_init3[i+3], sig_init3[i+2], sig_init3[i+1], sig_init3[i]});
  i=i+4;
end
i = 0;
for (j=0; j < IN_CNT3*4; j=j+32'h4) begin
  backdoor_write(j+32'h200a0000,input_init3[i][31:0]);
  i=i+1;
end
end
localparam IN_CNT4                = 32'd100352;
localparam IM_RAM_DEPTH4       = 32'd799;
localparam BIAS_RAM_DEPTH4     = 32'd1480;
localparam WEIGHT_RAM_DEPTH4   = 32'd1492;
localparam SIG_LUT_DEPTH4      = 32'd512;
localparam OUT_CNT4            = 32'd1280;
localparam INIT_SRC_ADDR4      = 32'h200b0000;
localparam NPU_SRC_ADDR4       = 32'h200c0000;
parameter SIG_INIT4          = "../../../../../tb/all_case_mif/./mif_mnist/sigmoid.mif";
parameter INSN_MEM_MIF4      = "../../../../../tb/all_case_mif/./mif_mnist/meminit_insn.mif";
parameter WEIGHT_MIF4        = "../../../../../tb/all_case_mif/./mif_mnist/meminit_w";
parameter BIAS_MIF4          = "../../../../../tb/all_case_mif/./mif_mnist/meminit_offset.mif";
parameter INPUT_VECTORS4     = "../../../../../tb/all_case_mif/./mif_mnist/meminit_input_vectors.mif";
reg [7:0] sig_init4 [SIG_LUT_DEPTH4-1:0];
initial begin
$readmemh(SIG_INIT4, sig_init4, 0, SIG_LUT_DEPTH4-1);
end
// instruction mem ram init.
reg [20:0] im_init4 [IM_RAM_DEPTH4-1:0];
initial begin
$readmemb(INSN_MEM_MIF4, im_init4, 0, IM_RAM_DEPTH4-1);
end
// weight ram init.
reg [128*8:0] mif_file4;
reg [7:0] weight_init4 [WEIGHT_RAM_DEPTH4*8-1:0];
reg [4:0] t4;
initial begin
  for (t4 = 0; t4 < 8; t4 = t4 + 1) begin
     $sformat(mif_file4, "%s%02d.mif", WEIGHT_MIF4, t4);
     $readmemh(mif_file4, weight_init4, WEIGHT_RAM_DEPTH4*t4, WEIGHT_RAM_DEPTH4*(t4+1)-1);
  end
end
// bias ram init.
reg [7:0] bias_init4 [BIAS_RAM_DEPTH4-1:0];
initial begin
  $readmemh(BIAS_MIF4, bias_init4, 0, BIAS_RAM_DEPTH4-1);
end
//input init. 
reg [63:0] input_init4 [IN_CNT4-1:0];
initial begin
  $readmemh(INPUT_VECTORS4, input_init4, 0, IN_CNT4-1);
end
initial begin
i = 0;
for (j=0;j < IM_RAM_DEPTH4*4;j=j+32'h4) begin
  backdoor_write(j+32'h200b0000,{11'b0,im_init4[i][20:0]});
  i=i+1;
end
i = 0;
for (j=IM_RAM_DEPTH4*4;j < (IM_RAM_DEPTH4*4 + WEIGHT_RAM_DEPTH4*8); j=j+32'h4) begin
  backdoor_write(j+32'h200b0000,{weight_init4[i+3],weight_init4[i+2],weight_init4[i+1],weight_init4[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH4*4 + WEIGHT_RAM_DEPTH4*8; j < IM_RAM_DEPTH4*4 + WEIGHT_RAM_DEPTH4*8+BIAS_RAM_DEPTH4; j=j+32'h4) begin
  backdoor_write(j+32'h200b0000,{ bias_init4[i+3], bias_init4[i+2], bias_init4[i+1], bias_init4[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH4*4 + WEIGHT_RAM_DEPTH4*8 + BIAS_RAM_DEPTH4; j < IM_RAM_DEPTH4*4 + WEIGHT_RAM_DEPTH4*8 + BIAS_RAM_DEPTH4 + SIG_LUT_DEPTH4; j=j+32'h4) begin
  backdoor_write(j+32'h200b0000,{ sig_init4[i+3], sig_init4[i+2], sig_init4[i+1], sig_init4[i]});
  i=i+4;
end
i = 0;
for (j=0; j < IN_CNT4*4; j=j+32'h4) begin
  backdoor_write(j+32'h200c0000,input_init4[i][31:0]);
  i=i+1;
end
end
localparam IN_CNT5                = 32'd45000;
localparam IM_RAM_DEPTH5       = 32'd56;
localparam BIAS_RAM_DEPTH5     = 32'd124;
localparam WEIGHT_RAM_DEPTH5   = 32'd124;
localparam SIG_LUT_DEPTH5      = 32'd512;
localparam OUT_CNT5            = 32'd5000;
localparam INIT_SRC_ADDR5      = 32'h20130000;
localparam NPU_SRC_ADDR5       = 32'h20140000;
parameter SIG_INIT5          = "../../../../../tb/all_case_mif/./mif_jmeint-in18-out2/sigmoid.mif";
parameter INSN_MEM_MIF5      = "../../../../../tb/all_case_mif/./mif_jmeint-in18-out2/meminit_insn.mif";
parameter WEIGHT_MIF5        = "../../../../../tb/all_case_mif/./mif_jmeint-in18-out2/meminit_w";
parameter BIAS_MIF5          = "../../../../../tb/all_case_mif/./mif_jmeint-in18-out2/meminit_offset.mif";
parameter INPUT_VECTORS5     = "../../../../../tb/all_case_mif/./mif_jmeint-in18-out2/meminit_input_vectors.mif";
reg [7:0] sig_init5 [SIG_LUT_DEPTH5-1:0];
initial begin
$readmemh(SIG_INIT5, sig_init5, 0, SIG_LUT_DEPTH5-1);
end
// instruction mem ram init.
reg [20:0] im_init5 [IM_RAM_DEPTH5-1:0];
initial begin
$readmemb(INSN_MEM_MIF5, im_init5, 0, IM_RAM_DEPTH5-1);
end
// weight ram init.
reg [128*8:0] mif_file5;
reg [7:0] weight_init5 [WEIGHT_RAM_DEPTH5*8-1:0];
reg [4:0] t5;
initial begin
  for (t5 = 0; t5 < 8; t5 = t5 + 1) begin
     $sformat(mif_file5, "%s%02d.mif", WEIGHT_MIF5, t5);
     $readmemh(mif_file5, weight_init5, WEIGHT_RAM_DEPTH5*t5, WEIGHT_RAM_DEPTH5*(t5+1)-1);
  end
end
// bias ram init.
reg [7:0] bias_init5 [BIAS_RAM_DEPTH5-1:0];
initial begin
  $readmemh(BIAS_MIF5, bias_init5, 0, BIAS_RAM_DEPTH5-1);
end
//input init. 
reg [63:0] input_init5 [IN_CNT5-1:0];
initial begin
  $readmemh(INPUT_VECTORS5, input_init5, 0, IN_CNT5-1);
end
initial begin
i = 0;
for (j=0;j < IM_RAM_DEPTH5*4;j=j+32'h4) begin
  backdoor_write(j+32'h20130000,{11'b0,im_init5[i][20:0]});
  i=i+1;
end
i = 0;
for (j=IM_RAM_DEPTH5*4;j < (IM_RAM_DEPTH5*4 + WEIGHT_RAM_DEPTH5*8); j=j+32'h4) begin
  backdoor_write(j+32'h20130000,{weight_init5[i+3],weight_init5[i+2],weight_init5[i+1],weight_init5[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH5*4 + WEIGHT_RAM_DEPTH5*8; j < IM_RAM_DEPTH5*4 + WEIGHT_RAM_DEPTH5*8+BIAS_RAM_DEPTH5; j=j+32'h4) begin
  backdoor_write(j+32'h20130000,{ bias_init5[i+3], bias_init5[i+2], bias_init5[i+1], bias_init5[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH5*4 + WEIGHT_RAM_DEPTH5*8 + BIAS_RAM_DEPTH5; j < IM_RAM_DEPTH5*4 + WEIGHT_RAM_DEPTH5*8 + BIAS_RAM_DEPTH5 + SIG_LUT_DEPTH5; j=j+32'h4) begin
  backdoor_write(j+32'h20130000,{ sig_init5[i+3], sig_init5[i+2], sig_init5[i+1], sig_init5[i]});
  i=i+4;
end
i = 0;
for (j=0; j < IN_CNT5*4; j=j+32'h4) begin
  backdoor_write(j+32'h20140000,input_init5[i][31:0]);
  i=i+1;
end
end
localparam IN_CNT6                = 32'd192000;
localparam IM_RAM_DEPTH6       = 32'd80;
localparam BIAS_RAM_DEPTH6     = 32'd132;
localparam WEIGHT_RAM_DEPTH6   = 32'd136;
localparam SIG_LUT_DEPTH6      = 32'd512;
localparam OUT_CNT6            = 32'd12000;
localparam INIT_SRC_ADDR6      = 32'h20170000;
localparam NPU_SRC_ADDR6       = 32'h20180000;
parameter SIG_INIT6          = "../../../../../tb/all_case_mif/./mif_jpeg_in64_out4/sigmoid.mif";
parameter INSN_MEM_MIF6      = "../../../../../tb/all_case_mif/./mif_jpeg_in64_out4/meminit_insn.mif";
parameter WEIGHT_MIF6        = "../../../../../tb/all_case_mif/./mif_jpeg_in64_out4/meminit_w";
parameter BIAS_MIF6          = "../../../../../tb/all_case_mif/./mif_jpeg_in64_out4/meminit_offset.mif";
parameter INPUT_VECTORS6     = "../../../../../tb/all_case_mif/./mif_jpeg_in64_out4/meminit_input_vectors.mif";
reg [7:0] sig_init6 [SIG_LUT_DEPTH6-1:0];
initial begin
$readmemh(SIG_INIT6, sig_init6, 0, SIG_LUT_DEPTH6-1);
end
// instruction mem ram init.
reg [20:0] im_init6 [IM_RAM_DEPTH6-1:0];
initial begin
$readmemb(INSN_MEM_MIF6, im_init6, 0, IM_RAM_DEPTH6-1);
end
// weight ram init.
reg [128*8:0] mif_file6;
reg [7:0] weight_init6 [WEIGHT_RAM_DEPTH6*8-1:0];
reg [4:0] t6;
initial begin
  for (t6 = 0; t6 < 8; t6 = t6 + 1) begin
     $sformat(mif_file6, "%s%02d.mif", WEIGHT_MIF6, t6);
     $readmemh(mif_file6, weight_init6, WEIGHT_RAM_DEPTH6*t6, WEIGHT_RAM_DEPTH6*(t6+1)-1);
  end
end
// bias ram init.
reg [7:0] bias_init6 [BIAS_RAM_DEPTH6-1:0];
initial begin
  $readmemh(BIAS_MIF6, bias_init6, 0, BIAS_RAM_DEPTH6-1);
end
//input init. 
reg [63:0] input_init6 [IN_CNT6-1:0];
initial begin
  $readmemh(INPUT_VECTORS6, input_init6, 0, IN_CNT6-1);
end
initial begin
i = 0;
for (j=0;j < IM_RAM_DEPTH6*4;j=j+32'h4) begin
  backdoor_write(j+32'h20170000,{11'b0,im_init6[i][20:0]});
  i=i+1;
end
i = 0;
for (j=IM_RAM_DEPTH6*4;j < (IM_RAM_DEPTH6*4 + WEIGHT_RAM_DEPTH6*8); j=j+32'h4) begin
  backdoor_write(j+32'h20170000,{weight_init6[i+3],weight_init6[i+2],weight_init6[i+1],weight_init6[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH6*4 + WEIGHT_RAM_DEPTH6*8; j < IM_RAM_DEPTH6*4 + WEIGHT_RAM_DEPTH6*8+BIAS_RAM_DEPTH6; j=j+32'h4) begin
  backdoor_write(j+32'h20170000,{ bias_init6[i+3], bias_init6[i+2], bias_init6[i+1], bias_init6[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH6*4 + WEIGHT_RAM_DEPTH6*8 + BIAS_RAM_DEPTH6; j < IM_RAM_DEPTH6*4 + WEIGHT_RAM_DEPTH6*8 + BIAS_RAM_DEPTH6 + SIG_LUT_DEPTH6; j=j+32'h4) begin
  backdoor_write(j+32'h20170000,{ sig_init6[i+3], sig_init6[i+2], sig_init6[i+1], sig_init6[i]});
  i=i+4;
end
i = 0;
for (j=0; j < IN_CNT6*4; j=j+32'h4) begin
  backdoor_write(j+32'h20180000,input_init6[i][31:0]);
  i=i+1;
end
end
localparam IN_CNT7                = 32'd230400;
localparam IM_RAM_DEPTH7       = 32'd18;
localparam BIAS_RAM_DEPTH7     = 32'd16;
localparam WEIGHT_RAM_DEPTH7   = 32'd16;
localparam SIG_LUT_DEPTH7      = 32'd512;
localparam OUT_CNT7            = 32'd38400;
localparam INIT_SRC_ADDR7      = 32'h20240000;
localparam NPU_SRC_ADDR7       = 32'h20250000;
parameter SIG_INIT7          = "../../../../../tb/all_case_mif/./mif_kmeans-in6-out1/sigmoid.mif";
parameter INSN_MEM_MIF7      = "../../../../../tb/all_case_mif/./mif_kmeans-in6-out1/meminit_insn.mif";
parameter WEIGHT_MIF7        = "../../../../../tb/all_case_mif/./mif_kmeans-in6-out1/meminit_w";
parameter BIAS_MIF7          = "../../../../../tb/all_case_mif/./mif_kmeans-in6-out1/meminit_offset.mif";
parameter INPUT_VECTORS7     = "../../../../../tb/all_case_mif/./mif_kmeans-in6-out1/meminit_input_vectors.mif";
reg [7:0] sig_init7 [SIG_LUT_DEPTH7-1:0];
initial begin
$readmemh(SIG_INIT7, sig_init7, 0, SIG_LUT_DEPTH7-1);
end
// instruction mem ram init.
reg [20:0] im_init7 [IM_RAM_DEPTH7-1:0];
initial begin
$readmemb(INSN_MEM_MIF7, im_init7, 0, IM_RAM_DEPTH7-1);
end
// weight ram init.
reg [128*8:0] mif_file7;
reg [7:0] weight_init7 [WEIGHT_RAM_DEPTH7*8-1:0];
reg [4:0] t7;
initial begin
  for (t7 = 0; t7 < 8; t7 = t7 + 1) begin
     $sformat(mif_file7, "%s%02d.mif", WEIGHT_MIF7, t7);
     $readmemh(mif_file7, weight_init7, WEIGHT_RAM_DEPTH7*t7, WEIGHT_RAM_DEPTH7*(t7+1)-1);
  end
end
// bias ram init.
reg [7:0] bias_init7 [BIAS_RAM_DEPTH7-1:0];
initial begin
  $readmemh(BIAS_MIF7, bias_init7, 0, BIAS_RAM_DEPTH7-1);
end
//input init. 
reg [63:0] input_init7 [IN_CNT7-1:0];
initial begin
  $readmemh(INPUT_VECTORS7, input_init7, 0, IN_CNT7-1);
end
initial begin
i = 0;
for (j=0;j < IM_RAM_DEPTH7*4;j=j+32'h4) begin
  backdoor_write(j+32'h20240000,{11'b0,im_init7[i][20:0]});
  i=i+1;
end
i = 0;
for (j=IM_RAM_DEPTH7*4;j < (IM_RAM_DEPTH7*4 + WEIGHT_RAM_DEPTH7*8); j=j+32'h4) begin
  backdoor_write(j+32'h20240000,{weight_init7[i+3],weight_init7[i+2],weight_init7[i+1],weight_init7[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH7*4 + WEIGHT_RAM_DEPTH7*8; j < IM_RAM_DEPTH7*4 + WEIGHT_RAM_DEPTH7*8+BIAS_RAM_DEPTH7; j=j+32'h4) begin
  backdoor_write(j+32'h20240000,{ bias_init7[i+3], bias_init7[i+2], bias_init7[i+1], bias_init7[i]});
  i=i+4;
end
i = 0;
for (j=IM_RAM_DEPTH7*4 + WEIGHT_RAM_DEPTH7*8 + BIAS_RAM_DEPTH7; j < IM_RAM_DEPTH7*4 + WEIGHT_RAM_DEPTH7*8 + BIAS_RAM_DEPTH7 + SIG_LUT_DEPTH7; j=j+32'h4) begin
  backdoor_write(j+32'h20240000,{ sig_init7[i+3], sig_init7[i+2], sig_init7[i+1], sig_init7[i]});
  i=i+4;
end
i = 0;
for (j=0; j < IN_CNT7*4; j=j+32'h4) begin
  backdoor_write(j+32'h20250000,input_init7[i][31:0]);
  i=i+1;
end
end
