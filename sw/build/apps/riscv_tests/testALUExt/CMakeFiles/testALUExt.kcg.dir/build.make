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

# Utility rule file for testALUExt.kcg.

# Include the progress variables for this target.
include apps/riscv_tests/testALUExt/CMakeFiles/testALUExt.kcg.dir/progress.make

apps/riscv_tests/testALUExt/CMakeFiles/testALUExt.kcg:
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testALUExt && pulp-pc-analyze --rtl --input=trace_core_00.log --binary=testALUExt.elf
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testALUExt && kcachegrind kcg.txt

testALUExt.kcg: apps/riscv_tests/testALUExt/CMakeFiles/testALUExt.kcg
testALUExt.kcg: apps/riscv_tests/testALUExt/CMakeFiles/testALUExt.kcg.dir/build.make

.PHONY : testALUExt.kcg

# Rule to build all files generated by this target.
apps/riscv_tests/testALUExt/CMakeFiles/testALUExt.kcg.dir/build: testALUExt.kcg

.PHONY : apps/riscv_tests/testALUExt/CMakeFiles/testALUExt.kcg.dir/build

apps/riscv_tests/testALUExt/CMakeFiles/testALUExt.kcg.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testALUExt && $(CMAKE_COMMAND) -P CMakeFiles/testALUExt.kcg.dir/cmake_clean.cmake
.PHONY : apps/riscv_tests/testALUExt/CMakeFiles/testALUExt.kcg.dir/clean

apps/riscv_tests/testALUExt/CMakeFiles/testALUExt.kcg.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/riscv_tests/testALUExt /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testALUExt /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testALUExt/CMakeFiles/testALUExt.kcg.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/riscv_tests/testALUExt/CMakeFiles/testALUExt.kcg.dir/depend

