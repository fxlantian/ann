# CMake generated Testfile for 
# Source directory: /home/pengfei/artix7-dev/sw/apps/fpga/gpio_demo
# Build directory: /home/pengfei/artix7-dev/sw/build/apps/fpga/gpio_demo
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(gpio_demo.test "tcsh" "-c" "env PPU_CORE=riscv VSIM_DIR=/home/pengfei/artix7-dev/vsim TB_TEST=\"\" /opt/modeltech/linux_x86_64/vsim  -c -64 -do 'source tcl_files/run.tcl; run_and_exit;'")
set_tests_properties(gpio_demo.test PROPERTIES  WORKING_DIRECTORY "/home/pengfei/artix7-dev/sw/build/apps/fpga/gpio_demo/")
