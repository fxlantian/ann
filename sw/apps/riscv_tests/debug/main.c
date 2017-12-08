// Copyright 2016 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

#include <stdio.h>
#include "bench.h"


void test_init(testresult_t *result, void (*start)(), void (*stop)());
void test_finish(testresult_t *result, void (*start)(), void (*stop)());

void test_rw_gpr(testresult_t *result, void (*start)(), void (*stop)());
void test_rw_csr(testresult_t *result, void (*start)(), void (*stop)());
void test_rw_dbg_regs(testresult_t *result, void (*start)(), void (*stop)());
void test_halt_resume(testresult_t *result, void (*start)(), void (*stop)());
void test_ebreak(testresult_t *result, void (*start)(), void (*stop)());
void test_npc_ppc(testresult_t *result, void (*start)(), void (*stop)());
void test_illegal(testresult_t *result, void (*start)(), void (*stop)());
void test_single_step(testresult_t *result, void (*start)(), void (*stop)());
void test_jumps(testresult_t *result, void (*start)(), void (*stop)());
void test_jumps_after_branch(testresult_t *result, void (*start)(), void (*stop)());
void test_branch(testresult_t *result, void (*start)(), void (*stop)());
void test_hardware_loop(testresult_t *result, void (*start)(), void (*stop)());
void test_nested_hardware_loop(testresult_t *result, void (*start)(), void (*stop)());
void test_illegal_hardware_loop(testresult_t *result, void (*start)(), void (*stop)());
void test_ss_hardware_loop(testresult_t *result, void (*start)(), void (*stop)());
void test_wfi_sleep(testresult_t *result, void (*start)(), void (*stop)());
void test_access_while_sleep(testresult_t *result, void (*start)(), void (*stop)());

testcase_t testcases[] = {
  { .name = "init",                           .test = test_init                  },

  { .name = " 2. test_rw_gpr",                .test = test_rw_gpr                },
  { .name = " 3. test_rw_csr",                .test = test_rw_csr                },
  { .name = " 4. test_rw_dbg_regs",           .test = test_rw_dbg_regs           },
  { .name = " 5. test_halt_resume",           .test = test_halt_resume           },
  { .name = " 6. test_ebreak",                .test = test_ebreak                },
  { .name = " 7. test_npc_ppc",               .test = test_npc_ppc               },
  { .name = " 8. test_illegal",               .test = test_illegal               },
  { .name = " 9. test_single_step",           .test = test_single_step           },
  { .name = "10. test_jumps",                 .test = test_jumps                 },
  { .name = "11. test_jumps_after_branch",    .test = test_jumps_after_branch    },
  { .name = "12. test_branch",                .test = test_branch                },
  { .name = "13. test_hardware_loop",         .test = test_hardware_loop         },
  { .name = "14. test_nested_hardware_loop",  .test = test_nested_hardware_loop  },
  { .name = "15. test_illegal_hardware_loop", .test = test_illegal_hardware_loop },
  { .name = "16. test_ss_hardware_loop",      .test = test_ss_hardware_loop      },
  { .name = "17. test_wfi_sleep",             .test = test_wfi_sleep             },
  { .name = "18. test_access_while_sleep",    .test = test_access_while_sleep    },

  { .name = "finish",                         .test = test_finish                },
  {0, 0}
};

volatile uint32_t testcase_current = 0;
volatile uint32_t tb_errors = 0;


int main() {
  return run_suite(testcases);
}

void test_init(testresult_t *result, void (*start)(), void (*stop)()) {
  //----------------------------------------------------------------------------
  // 1. Stop and tell TB about our testcase_current variable
  //----------------------------------------------------------------------------
  int * p = (volatile int *)0x1A110008;//Lei
  *p = 0xF;
  asm volatile ("mv x16, %[current];"
                "mv x17, %[tb_errors];"
                "ebreak" :: [current] "r" (&testcase_current), [tb_errors] "r" (&tb_errors));
}

void test_finish(testresult_t *result, void (*start)(), void (*stop)()) {
  testcase_current = 0xFFFFFFFF;
  asm volatile ("ebreak");

  result->errors += tb_errors;
}

//----------------------------------------------------------------------------
// 2. Fill GPRs with well known data
//----------------------------------------------------------------------------
void test_rw_gpr(testresult_t *result, void (*start)(), void (*stop)()) {
  uint32_t a, b, c;

  testcase_current = 2;

  asm volatile ("li x5, 0x55555555;"
                "li x6, 0x12345666;"
                "li x7, 0x77;"
                "li x18, 0x88;"
                "li x31, 0x31;"
                "ebreak;"
                ::: "x5", "x6", "x7", "x18", "x31");

  // now read back some values written by the debug system
  asm volatile ("ebreak;"
                "mv %[a], x5;"
                "mv %[b], x6;"
                "mv %[c], x31;"
                : [a] "=r" (a), [b] "=r" (b), [c] "=r" (c) :: "x5", "x6", "x31");

  check_uint32(result, "x5",  a, 0x54321089);
  check_uint32(result, "x6",  b, 0x11223344);
  check_uint32(result, "x31", c, 0xFEDCBA09);
}

//----------------------------------------------------------------------------
// 3. Check CSR access
//----------------------------------------------------------------------------
void test_rw_csr(testresult_t *result, void (*start)(), void (*stop)()) {
  uint32_t a, b;

  testcase_current = 3;

  asm volatile ("csrw 0x300, %[a];"
                "csrw 0x341, %[b];"
                "ebreak;" :: [a] "r" (0x1), [b] "r" (0x12345678));

  // now read back some values written by the debug system
  asm volatile ("ebreak;"
                "csrr %[a], 0x300;"
                "csrr %[b], 0x341;"
                : [a] "=r" (a), [b] "=r" (b));

  check_uint32(result, "mstatus",  a, 0x00000006);
  check_uint32(result, "mepc",     b, 0x87654321);
}

//----------------------------------------------------------------------------
// 4. Check Debug Register access
//----------------------------------------------------------------------------
void test_rw_dbg_regs(testresult_t *result, void (*start)(), void (*stop)()) {
  uint32_t a, b;

  testcase_current = 4;

  asm volatile ("ebreak");
}

//----------------------------------------------------------------------------
// 5. Halt and resume core a couple of times
//----------------------------------------------------------------------------
void test_halt_resume(testresult_t *result, void (*start)(), void (*stop)()) {
  uint32_t a, b;
  volatile uint32_t changeme = 1;

  testcase_current = 5;

  asm volatile ("mv x16, %[addr];"
                "ebreak" :: [addr] "r" (&changeme));

  while(changeme);

  asm volatile ("ebreak");
}

//----------------------------------------------------------------------------
// 6. ebreak, ebreak, ebreak
//
// Check if PPC and NPC work correctly
//----------------------------------------------------------------------------
void test_ebreak(testresult_t *result, void (*start)(), void (*stop)()) {
  testcase_current = 6;

  asm volatile ("nop;"
                "ebreak;"
                "ebreak;"
                "ebreak;"
                "ebreak;"
                "ebreak;"
                "ebreak;"
                "ebreak;"
                "ebreak;"
                "ebreak;"
                "ebreak;");
}

//----------------------------------------------------------------------------
// 7. NPC and PPC values
//----------------------------------------------------------------------------
void test_npc_ppc(testresult_t *result, void (*start)(), void (*stop)()) {
  testcase_current = 7;

  asm volatile ("ebreak");

  asm volatile ("la x16, before;"
                "li x17, 0x26000088;"
                "la x18, after;"
                "        nop;"
                "before: ecall;"
                "after:  nop"
                ::: "x16", "x17", "x18");
}

//----------------------------------------------------------------------------
// 8. Illegal Instruction Exception
//----------------------------------------------------------------------------
void test_illegal(testresult_t *result, void (*start)(), void (*stop)()) {
  testcase_current = 8;

  asm volatile ("ebreak");

  asm volatile ("la x16,     before_ill;"
                "li x17,     0x26000084;"
                "la x18,     after_ill;"
                "            nop;"
                "before_ill: .word 0xF0F0F0F;"
                "after_ill:  nop"
                ::: "x16", "x17", "x18");
}

//----------------------------------------------------------------------------
// 9. Single Step
//----------------------------------------------------------------------------
void test_single_step(testresult_t *result, void (*start)(), void (*stop)()) {
  volatile uint32_t changeme = 1;
  volatile uint32_t act = 0;
  testcase_current = 9;

  // check single-step with addi
  asm volatile ("ebreak;"
                "addi %[a], %[a], 1;"
                "addi %[a], %[a], 2;"
                "addi %[a], %[a], 4;"
                "addi %[a], %[a], 8;"
                : [a] "+r" (act));

  check_uint32(result, "addi single step", act, 1 + 2 + 4 + 8);

  //----------------------------------------------------------------------------
  // check tight branch loop with load
  //----------------------------------------------------------------------------
  asm volatile ("ebreak;"
                "mv x16, %[addr];"
                "ss_start: lw x17, 0(x16);"
                "          bne x0, x17, ss_start;"
                :: [addr] "r" (&changeme) : "x16", "x17");

  //----------------------------------------------------------------------------
  // check tight branch loop with only bf, so we have to jump out
  //----------------------------------------------------------------------------
  asm volatile ("ebreak;"
                "la x16, tb_jump;"
                "tb_start: beq x0, x0, tb_start;"
                "tb_jump:  nop;");

  //----------------------------------------------------------------------------
  // check tight loop with no exit, so we have to jump out
  //----------------------------------------------------------------------------
  asm volatile ("ebreak;"
                "la x16, tl_jump;"
                "tl_start: j tl_start;"
                "tl_jump:  nop;");
}

//----------------------------------------------------------------------------
// 10. Jumps with NPC setting
//----------------------------------------------------------------------------
void test_jumps(testresult_t *result, void (*start)(), void (*stop)()) {
  uint32_t act = 0;
  testcase_current = 10;

  // check jumps with addi
  asm volatile ("la x16, jmp1;"
                "ebreak;"
                "      addi %[a], %[a], 1;"
                "      addi %[a], %[a], 2;"
                "jmp1: addi %[a], %[a], 4;"
                "      addi %[a], %[a], 8;"
                : [a] "+r" (act)
                :: "x16");

  check_uint32(result, "jmp1", act, 4 + 8);

  // check jumps to ebreak
  asm volatile ("la x16, jmpe;"
                "ebreak;"
                "      j jmpd;"
                "      nop;"
                "jmpe: ebreak;"
                "      nop;"
                "jmpd: nop;"
                ::: "x16");
}

//----------------------------------------------------------------------------
// 11. Jumps after Branch, in single-stepping mode
//----------------------------------------------------------------------------
void test_jumps_after_branch(testresult_t *result, void (*start)(), void (*stop)()) {
  uint32_t act = 0;
  testcase_current = 11;

  // check jumps after branch taken
  asm volatile ("        la  x16, bt_11;"
                "        la  x17, jmp_11;"
                "        la  x18, pc0_11;"
                "        la  x19, pc1_11;"
                "        ebreak;"
                "pc0_11: addi %[a], x0, 4;"
                "pc1_11: beq x0, x0, bt_11;"
                "        j jmp_11;"
                "        nop;"
                "bt_11:  addi %[a], x0, 2;"
                "jmp_11: nop;"
                : [a] "=r" (act)
                ::  "x16", "x17", "x18", "x19");

  check_uint32(result, "branch_aft_jmp_t", act, 2);

  // check jumps after branch not taken
  asm volatile ("          la  x16, pc2_11_2;"
                "          la  x17, jmp_11_2;"
                "          la  x18, pc0_11_2;"
                "          la  x19, pc1_11_2;"
                "          ebreak;"
                "pc0_11_2: addi %[a], x0, 4;"
                "pc1_11_2: beq x0, x16, bt_11_2;"
                "pc2_11_2: j jmp_11_2;"
                "bt_11_2:  addi %[a], x0, 2;"
                "jmp_11_2: nop;"
                : [a] "=r" (act)
                ::  "x16", "x17", "x18", "x19");

  check_uint32(result, "branch_aft_jmp_nt", act, 4);
}

//----------------------------------------------------------------------------
// 12. Branch Taken and not taken, in single-stepping mode
//----------------------------------------------------------------------------
void test_branch(testresult_t *result, void (*start)(), void (*stop)()) {
  uint32_t act = 0;
  testcase_current = 12;

  // check branch taken toward
  asm volatile ("         la  x16, pc_btt_0;"
                "         la  x17, pc_btt_1;"
                "         la  x18, pc_btt_2;"
                "         la  x19, pc_btt_3;"
                "         ebreak;"
                "pc_btt_0: addi %[a], %[a], 4;"
                "pc_btt_1: beq x0, x0, pc_btt_2;"
                "         j pc_btt_0;"
                "pc_btt_2: addi %[a], %[a], 2;"
                "pc_btt_3: nop;"
                : [a] "+r" (act)
                ::  "x16", "x17", "x18", "x19");

  check_uint32(result, "branch_taken_toward", act, 4+2);

  act = 0;
  // check branch not taken toward
  asm volatile ("         la  x16, pc_bnt_0;"
                "         la  x17, pc_bnt_1;"
                "         la  x18, pc_bnt_2;"
                "         la  x19, pc_bnt_3;"
                "         addi %[a], %[a], 4;"
                "         ebreak;"
                "pc_bnt_0: bne x0, x0, pc_bnt_2;"
                "pc_bnt_1: j pc_bnt_3;"
                "pc_bnt_2: addi %[a], %[a], 2;"
                "pc_bnt_3: nop;"
                : [a] "+r" (act)
                ::  "x16", "x17", "x18", "x19");

  check_uint32(result, "branch_not_taken_toward", act, 4);

  act = 0;
  // check branch taken backward
  asm volatile ("         la  x16, pc_btb_0;"
                "         la  x17, pc_btb_1;"
                "         la  x18, pc_btb_2;"
                "         la  x19, pc_btb_3;"
                "         ebreak;"
                "pc_btb_0: addi %[a], %[a], 1;"
                "pc_btb_1: bne %[k], %[a], pc_btb_0;"
                "pc_btb_2: j pc_btb_3;"
                "         addi %[a], %[a], 2;"
                "pc_btb_3: nop;"
                : [a] "+r" (act)
                : [k] "r"  (10)
                :  "x16", "x17", "x18", "x19");

  check_uint32(result, "branch_taken_backward", act, 10);

  act = 0;
  // check branch not taken backward
  asm volatile ("         la  x16, pc_bnb_0;"
                "         la  x17, pc_bnb_1;"
                "         la  x18, pc_bnb_2;"
                "         la  x19, pc_bnb_3;"
                "         ebreak;"
                "pc_bnb_0: addi %[a], %[a], 1;"
                "pc_bnb_1: beq %[k], %[a], pc_bnb_0;"
                "pc_bnb_2: j pc_bnb_3;"
                "pc_bnb_3: addi %[a], %[a], 2;"
                : [a] "+r" (act)
                : [k] "r"  (10)
                :  "x16", "x17", "x18", "x19");

  check_uint32(result, "branch_not_taken_backward", act, 1+2);
}

#define HWLP_COUNTI 10
//----------------------------------------------------------------------------
// 13. Hardware Loop
//----------------------------------------------------------------------------
void test_hardware_loop(testresult_t *result, void (*start)(), void (*stop)()) {
  uint32_t act = 0;
  testcase_current = 13;

  // check hardware loop size 4, loop#0
  asm volatile ("lp.counti x0, %[N];"
                "lp.starti x0, start_HWLP_1;"
                "lp.endi   x0, end_HWLP_1;"
                "start_HWLP_1: addi %[act], %[act], 1;"
                "              ebreak;"
                "              addi %[act], %[act], 2;"
                "end_HWLP_1:   addi %[act], %[act], 3;"
                : [act] "+r" (act)
                : [N]   "i"  (HWLP_COUNTI));


  check_uint32(result, "hardware_loop", act, HWLP_COUNTI*(1+2+3));

  act = 0;
  // check hardware loop size 3, loop#0
  asm volatile ("lp.counti x0, %[N];"
                "lp.starti x0, start_HWLP_2;"
                "lp.endi   x0, end_HWLP_2;"
                "start_HWLP_2: ebreak;"
                "              addi %[act], %[act], 1;"
                "end_HWLP_2:   addi %[act], %[act], 2;"
                : [act] "+r" (act)
                : [N]   "i"  (2*HWLP_COUNTI));


  check_uint32(result, "hardware_loop", act, 2*HWLP_COUNTI*(1+2));

  act = 0;
  // check hardware loop size 2, loop#1
  asm volatile ("lp.counti x1, %[N];"
                "lp.starti x1, start_HWLP_3;"
                "lp.endi   x1, end_HWLP_3;"
                "start_HWLP_3: addi %[act], %[act], 1;"
                "end_HWLP_3:   ebreak;"
                : [act] "+r" (act)
                : [N]   "i"  (3*HWLP_COUNTI));


  check_uint32(result, "hardware_loop", act, 3*HWLP_COUNTI*(1));

  act = 0;
  // check hardware loop size 2, ebreak after lp.counti, loop#1
  asm volatile ("la x16, %[N];"
                "lp.counti x1, %[N];"
                "ebreak;"
                "lp.starti x1, start_HWLP_4;"
                "lp.endi   x1, end_HWLP_4;"
                "start_HWLP_4: addi %[act], %[act], 1;"
                "end_HWLP_4:   nop;"
                : [act] "+r" (act)
                : [N]   "i"  (3*HWLP_COUNTI)
                : "x16");


  check_uint32(result, "hardware_loop", act, 3*HWLP_COUNTI*(1));

  act = 0;
  // check hardware loop size 2, ebreak after lp.starti, loop#1
  asm volatile ("la x16, %[N];"
                "la x17, start_HWLP_5;"
                "lp.counti x1, %[N];"
                "lp.starti x1, start_HWLP_5;"
                "ebreak;"
                "lp.endi   x1, end_HWLP_5;"
                "start_HWLP_5: addi %[act], %[act], 1;"
                "end_HWLP_5:   nop;"
                : [act] "+r" (act)
                : [N]   "i"  (3*HWLP_COUNTI)
                : "x16", "x17");

  act = 0;
  // check hardware loop size 2, ebreak after lp.endi, loop#1
  asm volatile ("la x16, %[N];"
                "la x17, start_HWLP_6;"
                "la x18, end_HWLP_6;"
                "lp.counti x1, %[N];"
                "lp.starti x1, start_HWLP_6;"
                "lp.endi   x1, end_HWLP_6;"
                "ebreak;"
                "start_HWLP_6: addi %[act], %[act], 1;"
                "end_HWLP_6:   nop;"
                : [act] "+r" (act)
                : [N]   "i"  (3*HWLP_COUNTI)
                : "x16", "x17", "x18");


  check_uint32(result, "hardware_loop", act, 3*HWLP_COUNTI*(1));

}

//----------------------------------------------------------------------------
// 14. Nested Hardware Loop
//----------------------------------------------------------------------------
void test_nested_hardware_loop(testresult_t *result, void (*start)(), void (*stop)()) {
  uint32_t act = 0;
  testcase_current = 14;

  asm volatile ("la x16, %[N];"
                "la x17, start_HWLP_7;"
                "la x18, end_HWLP_7;"
                "lp.counti x1, %[N];"
                "lp.starti x1, start_HWLP_7;"
                "lp.endi   x1, end_HWLP_7;"
                "ebreak;" // <--- first ebreak, happens once
                "la x19, %[N_in];"
                "la x20, start_HWLP_7_in;"
                "la x21, end_HWLP_7;"
                "start_HWLP_7: lp.counti x0, %[N_in];"
                "lp.starti x0, start_HWLP_7_in;"
                "lp.endi   x0, end_HWLP_7;"
                "ebreak;" // <--- second ebreak, happens HWLP_COUNTI/2 times
                "start_HWLP_7_in: addi %[act], %[act], 1;"
                "end_HWLP_7:      ebreak;" // <--- third ebreak, happens HWLP_COUNTI*HWLP_COUNTI/2 times
                : [act] "+r" (act)
                : [N]   "i"  (HWLP_COUNTI/2), [N_in]   "i"  (HWLP_COUNTI)
                : "x16", "x17", "x18", "x19", "x20", "x21");


  check_uint32(result, "nested_hardware_loop", act, HWLP_COUNTI*HWLP_COUNTI/2);


}

//----------------------------------------------------------------------------
// 15. Illegal Hardware Loop
//----------------------------------------------------------------------------
void test_illegal_hardware_loop(testresult_t *result, void (*start)(), void (*stop)()) {
  uint32_t act = 0;
  testcase_current = 15;

  // Illegal instruction is the last one, a patch in the debugger in order to
  // decrement the hwlp counter is needed

  asm volatile ("la x16, start_HWLP_8;"
                "li x17, 0x26000084;"
                "la x18, end_HWLP_8;"
                "la x19, end_HWLP_8_1;"
                "lp.counti x0, %[N];"
                "lp.starti x0, start_HWLP_8;"
                "lp.endi   x0, end_HWLP_8;"
                "ebreak;"
                "start_HWLP_8: addi %[act], %[act], 1;"
                "end_HWLP_8:   .word 0xF0F0F0F;"
                "end_HWLP_8_1: nop;"
                : [act] "+r" (act)
                : [N]   "i"  (HWLP_COUNTI)
                : "x16", "x17", "x18", "x19");

  check_uint32(result, "illegal_hardware_loop", act, HWLP_COUNTI);

  // Illegal instruction is not the last one, normal debug is ok
  act = 0;
  asm volatile ("la x16, start_HWLP_9;"
                "li x17, 0x26000084;"
                "la x18, end_HWLP_9;"
                "la x19, before_ill_hwlp;"
                "lp.counti x0, %[N];"
                "lp.starti x0, start_HWLP_9;"
                "lp.endi   x0, end_HWLP_9;"
                "ebreak;"
                "start_HWLP_9:    addi %[act], %[act], 1;"
                "before_ill_hwlp: .word 0xF0F0F0F;"
                "end_HWLP_9:      nop;"
                : [act] "+r" (act)
                : [N]   "i"  (HWLP_COUNTI)
                : "x16", "x17", "x18", "x19");


  check_uint32(result, "illegal_hardware_loop", act, HWLP_COUNTI);


}

//----------------------------------------------------------------------------
// 16. Hardware Loop Single Step
//----------------------------------------------------------------------------
void test_ss_hardware_loop(testresult_t *result, void (*start)(), void (*stop)()) {
  volatile uint32_t act = 0;
  uint32_t act_add = (uint32_t)&act;

  testcase_current = 16;

  act = 0;
  asm volatile ("la x16, start_HWLP_10;"
                "la x17, middle_HWLP_10;"
                "la x18, end_HWLP_10;"
                "la x19, %[N];"
                "la x22, store_HWLP_10;"
                "mv x20, %[act_add];"
                "xor x21, x21, x21;"
                "lp.counti x0, %[N];"
                "lp.starti x0, start_HWLP_10;"
                "lp.endi   x0, end_HWLP_10;"
                "ebreak;"
                "start_HWLP_10:    addi x21, x21, 1;"
                "middle_HWLP_10:   addi x21, x21, 2;"
                "end_HWLP_10:      addi x21, x21, 3;"
                "store_HWLP_10:    sw x21, 0(%[act_add]);"
                :
                : [N]   "i"  (HWLP_COUNTI), [act_add] "r" (act_add)
                : "x16", "x17", "x18", "x19", "x20", "x21", "x22");


  check_uint32(result, "ss_hardware_loop", act, HWLP_COUNTI*(1+2+3));


}

//----------------------------------------------------------------------------
// 17. WFI and sleep
//----------------------------------------------------------------------------
void test_wfi_sleep(testresult_t *result, void (*start)(), void (*stop)()) {
  uint32_t act = 0;
  testcase_current = 17;

  //----------------------------------------------------------------------------
  // single step mode
  //----------------------------------------------------------------------------
  asm volatile ("la x16, WFI_PPC_1;"
                "la x17, WFI_NPC_1;"
                "la x18, WFI_NPC_2;"
                "ebreak;"
                "WFI_PPC_1: wfi;"
                "WFI_NPC_1: addi %[act], %[act], 1;"
                "WFI_NPC_2: addi %[act], %[act], 2;"
                : [act] "+r" (act)
                :
                : "x16", "x17", "x18");

  check_uint32(result, "wfi", act, 1+2);

  //----------------------------------------------------------------------------
  // single step mode
  //----------------------------------------------------------------------------
  act = 0;
  asm volatile ("la x16, SLEEP_SS_NPC_1;"
                "la x17, SLEEP_SS_NPC_2;"
                "la x18, SLEEP_SS_NPC_3;"
                "la x19, SLEEP_SS_NPC_4;"
                "la x20, SLEEP_SS_NPC_5;"
                "ebreak;"
                "SLEEP_SS_NPC_1: sw %[one], 0x20(%[addr]);"
                "SLEEP_SS_NPC_2: wfi;"
                "SLEEP_SS_NPC_3: nop;"
                "SLEEP_SS_NPC_4: addi %[act], %[act], 10;"
                "SLEEP_SS_NPC_5: addi %[act], %[act], 10;"
                "                sw x0, 0x20(%[addr]);"
                : [act]  "+r" (act)
                : [one]  "r" (0x1), [addr]  "r" (EVENT_UNIT_BASE_ADDR)
                : "x16", "x17", "x18", "x19", "x20");

  check_uint32(result, "sleep_ss", act, 20);

  //----------------------------------------------------------------------------
  // single step mode during sleep
  // TB wakes us up again
  //----------------------------------------------------------------------------
  act = 0;
  asm volatile ("la x16, SLEEP_SSW_PC_1;"
                "la x17, SLEEP_SSW_PC_2;"
                "la x18, SLEEP_SSW_PC_3;"
                "                ebreak;"
                "SLEEP_SSW_PC_1: sw %[one], 0x20(%[addr]);"
                "SLEEP_SSW_PC_2: wfi;"
                "SLEEP_SSW_PC_3: addi %[act], %[act], 10;"
                "                addi %[act], %[act], 10;"
                : [act]  "+r" (act)
                : [one]  "r" (0x1), [addr]  "r" (EVENT_UNIT_BASE_ADDR)
                : "x16", "x17", "x18");

  check_uint32(result, "sleep_ss", act, 20);
}

//----------------------------------------------------------------------------
// 18. Access while sleep
//----------------------------------------------------------------------------
void test_access_while_sleep(testresult_t *result, void (*start)(), void (*stop)()) {
  uint32_t gpr = 0;
  uint32_t csr = 0xB15B00B5;
  testcase_current = 18;

  // check if we can access internal registers while the core is sleeping
  // This includes GPR, CSR and Debug Registers
  asm volatile ("         ebreak;"
                "         sw %[one], 0x20(%[event_unit]);"
                "         li x16, 0x16161616;"
                "         li x17, 0x17171717;"
                "         la x18, aws_wfi;"
                "         csrw 0x780, %[csr];"
                "aws_wfi: wfi;"
                "         sw x0, 0x14(%[event_unit]);"
                "         mv   %[gpr], x16;"
                "         csrr %[csr], 0x780;"
                : [gpr] "+r"       ( gpr        ),
                  [csr] "+r"       ( csr        )
                : [one] "r"        ( 0x1        ),
                  [event_unit] "r" ( EVENT_UNIT_BASE_ADDR )
                : "x16", "x17", "x18");

  check_uint32(result, "gpr written", gpr, 0xFEDCBA00);
  check_uint32(result, "csr written", csr, 0xC0DE1234);

  // Identical to the one before, but this time we exit the sleep mode by setting the NPC register
  asm volatile ("         ebreak;"
                "         sw %[one], 0x20(%[event_unit]);"
                "         li x16, 0x16161616;"
                "         li x17, 0x17171717;"
                "         la x18, aws_nsl;"
                "         csrw 0x780, %[csr];"
                "         wfi;"
                "aws_nsl: sw x0, 0x14(%[event_unit]);"
                "         mv   %[gpr], x16;"
                "         csrr %[csr], 0x780;"
                : [gpr] "+r"       ( gpr        ),
                  [csr] "+r"       ( csr        )
                : [one] "r"        ( 0x1        ),
                  [event_unit] "r" ( EVENT_UNIT_BASE_ADDR )
                : "x16", "x17", "x18");

  check_uint32(result, "gpr written", gpr, 0xFEDCBA00);
  check_uint32(result, "csr written", csr, 0xC0DE1234);
}
