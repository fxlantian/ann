# CMake generated Testfile for 
# Source directory: /home/pengfei/artix7-dev/sw/apps/sequential_tests/matrixAdd
# Build directory: /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/matrixAdd
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(matrixAdd32.test "tcsh" "-c" "env PPU_CORE=riscv VSIM_DIR=/home/pengfei/artix7-dev/vsim TB_TEST=\"\" /opt/modeltech/linux_x86_64/vsim  -c -64 -do 'source tcl_files/run.tcl; run_and_exit;'")
set_tests_properties(matrixAdd32.test PROPERTIES  LABELS "sequential_tests" WORKING_DIRECTORY "/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/matrixAdd/matrixAdd32")
add_test(matrixAdd16.test "tcsh" "-c" "env PPU_CORE=riscv VSIM_DIR=/home/pengfei/artix7-dev/vsim TB_TEST=\"\" /opt/modeltech/linux_x86_64/vsim  -c -64 -do 'source tcl_files/run.tcl; run_and_exit;'")
set_tests_properties(matrixAdd16.test PROPERTIES  LABELS "sequential_tests" WORKING_DIRECTORY "/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/matrixAdd/matrixAdd16")
add_test(matrixAdd8.test "tcsh" "-c" "env PPU_CORE=riscv VSIM_DIR=/home/pengfei/artix7-dev/vsim TB_TEST=\"\" /opt/modeltech/linux_x86_64/vsim  -c -64 -do 'source tcl_files/run.tcl; run_and_exit;'")
set_tests_properties(matrixAdd8.test PROPERTIES  LABELS "sequential_tests" WORKING_DIRECTORY "/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/matrixAdd/matrixAdd8")
