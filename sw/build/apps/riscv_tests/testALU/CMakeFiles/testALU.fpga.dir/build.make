# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/pengfei/artix7-dev/sw

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/pengfei/artix7-dev/sw/build

# Utility rule file for testALU.fpga.

# Include the progress variables for this target.
include apps/riscv_tests/testALU/CMakeFiles/testALU.fpga.dir/progress.make

apps/riscv_tests/testALU/CMakeFiles/testALU.fpga:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Running testALU on FPGA"
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testALU && /home/pengfei/artix7-dev/sw/utils/run-on-fpga.sh testALU

testALU.fpga: apps/riscv_tests/testALU/CMakeFiles/testALU.fpga
testALU.fpga: apps/riscv_tests/testALU/CMakeFiles/testALU.fpga.dir/build.make

.PHONY : testALU.fpga

# Rule to build all files generated by this target.
apps/riscv_tests/testALU/CMakeFiles/testALU.fpga.dir/build: testALU.fpga

.PHONY : apps/riscv_tests/testALU/CMakeFiles/testALU.fpga.dir/build

apps/riscv_tests/testALU/CMakeFiles/testALU.fpga.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testALU && $(CMAKE_COMMAND) -P CMakeFiles/testALU.fpga.dir/cmake_clean.cmake
.PHONY : apps/riscv_tests/testALU/CMakeFiles/testALU.fpga.dir/clean

apps/riscv_tests/testALU/CMakeFiles/testALU.fpga.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/riscv_tests/testALU /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testALU /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testALU/CMakeFiles/testALU.fpga.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/riscv_tests/testALU/CMakeFiles/testALU.fpga.dir/depend

