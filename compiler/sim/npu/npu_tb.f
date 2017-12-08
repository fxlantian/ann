// Simulation files for pre-synthesis

//=============================================================================
// Testbench
//=============================================================================
npu_tb.v

//=============================================================================
// Sources
//=============================================================================
// macros and params implicitly included
../../rtl/npu.v
../../rtl/pu.v
../../rtl/pe.v
../../rtl/sigmoid.v
../../rtl/sigmoid_lut.v
../../rtl/acc_fifo.v

// Generic IP cores
../../rtl/madd_generic.v
../../rtl/madd_ch_generic.v
../../rtl/fifo_fwf.v
../../rtl/fifo_fwf_128x26.v
../../rtl/fifo_fwf_128x8.v
../../rtl/fifo_fwf_input.v
../../rtl/ram.v
../../rtl/ram_512x32.v
../../rtl/ram_128x26.v
../../rtl/ram_128x8.v
../../rtl/ram_256x32_2p.v
../../rtl/ram_128x26_2p.v
