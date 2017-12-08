#!/bin/bash

OBJDUMP=`which riscv32-unknown-elf-objdump`
OBJCOPY=`which riscv32-unknown-elf-objcopy`

COMPILER=`which riscv32-unknown-elf-gcc`

TARGET_C_FLAGS="-O3 -m32 -g"

VSIM=`which vsim`

# if you want to have compressed instructions, set this to 1
RVC=1

# if you are using the ETH gcc compiler that supports the extended instruction
# of RI5CY, set this to 1
# Otherwise it is assumed that the official riscv compiler is used and no special
# instructions are inserted
GCC_ETH=1


PPU_GIT_DIRECTORY=../../
SIM_DIRECTORY="$PPU_GIT_DIRECTORY/vsim"

cmake "$PPU_GIT_DIRECTORY"/sw/ \
    -DPPU_MODELSIM_DIRECTORY="$SIM_DIRECTORY" \
    -DCMAKE_C_COMPILER="$COMPILER" \
    -DVSIM="$VSIM" \
    -DRVC="$RVC" \
    -DGCC_ETH="$GCC_ETH" \
    -DCMAKE_C_FLAGS="$TARGET_C_FLAGS" \
    -DCMAKE_OBJCOPY="$OBJCOPY" \
    -DCMAKE_OBJDUMP="$OBJDUMP"

# Add -G "Ninja" to the cmake call above to use ninja instead of make
