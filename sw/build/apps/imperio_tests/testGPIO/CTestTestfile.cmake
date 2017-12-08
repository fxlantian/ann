# CMake generated Testfile for 
# Source directory: /home/pengfei/artix7-dev/sw/apps/imperio_tests/testGPIO
# Build directory: /home/pengfei/artix7-dev/sw/build/apps/imperio_tests/testGPIO
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(testGPIO.test "tcsh" "-c" "env PPU_CORE=riscv VSIM_DIR=/home/pengfei/artix7-dev/vsim TB_TEST=\"MUX_GPIO\" /opt/modeltech/linux_x86_64/vsim  -c -64 -do 'source tcl_files/run_spi_standalone.tcl; run_and_exit;'")
set_tests_properties(testGPIO.test PROPERTIES  LABELS "imperio_tests" WORKING_DIRECTORY "/home/pengfei/artix7-dev/sw/build/apps/imperio_tests/testGPIO/")
