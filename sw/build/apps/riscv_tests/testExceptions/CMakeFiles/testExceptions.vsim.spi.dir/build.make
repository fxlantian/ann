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

# Utility rule file for testExceptions.vsim.spi.

# Include the progress variables for this target.
include apps/riscv_tests/testExceptions/CMakeFiles/testExceptions.vsim.spi.dir/progress.make

apps/riscv_tests/testExceptions/CMakeFiles/testExceptions.vsim.spi:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Running testExceptions in ModelSim"
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testExceptions && /usr/bin/cmake -E remove stdout/*
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testExceptions && /usr/bin/cmake -E remove FS/*
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testExceptions && tcsh -c env\ PPU_CORE=riscv\ VSIM_DIR=/home/pengfei/artix7-dev/vsim\ TB_TEST=""\ /opt/modeltech/linux_x86_64/vsim\ \ -64\ -do\ 'source\ tcl_files/run_spi.tcl\;'

testExceptions.vsim.spi: apps/riscv_tests/testExceptions/CMakeFiles/testExceptions.vsim.spi
testExceptions.vsim.spi: apps/riscv_tests/testExceptions/CMakeFiles/testExceptions.vsim.spi.dir/build.make

.PHONY : testExceptions.vsim.spi

# Rule to build all files generated by this target.
apps/riscv_tests/testExceptions/CMakeFiles/testExceptions.vsim.spi.dir/build: testExceptions.vsim.spi

.PHONY : apps/riscv_tests/testExceptions/CMakeFiles/testExceptions.vsim.spi.dir/build

apps/riscv_tests/testExceptions/CMakeFiles/testExceptions.vsim.spi.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testExceptions && $(CMAKE_COMMAND) -P CMakeFiles/testExceptions.vsim.spi.dir/cmake_clean.cmake
.PHONY : apps/riscv_tests/testExceptions/CMakeFiles/testExceptions.vsim.spi.dir/clean

apps/riscv_tests/testExceptions/CMakeFiles/testExceptions.vsim.spi.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/riscv_tests/testExceptions /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testExceptions /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testExceptions/CMakeFiles/testExceptions.vsim.spi.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/riscv_tests/testExceptions/CMakeFiles/testExceptions.vsim.spi.dir/depend

