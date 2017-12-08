# CMake generated Testfile for 
# Source directory: /home/pengfei/artix7-dev/sw/apps/sequential_tests/stencil
# Build directory: /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/stencil
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(stencil.test "tcsh" "-c" "env PPU_CORE=riscv VSIM_DIR=/home/pengfei/artix7-dev/vsim TB_TEST=\"\" /opt/modeltech/linux_x86_64/vsim  -c -64 -do 'source tcl_files/run.tcl; run_and_exit;'")
set_tests_properties(stencil.test PROPERTIES  WORKING_DIRECTORY "/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/stencil/")
