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

# Utility rule file for debug.read.

# Include the progress variables for this target.
include apps/riscv_tests/debug/CMakeFiles/debug.read.dir/progress.make

debug.read: apps/riscv_tests/debug/CMakeFiles/debug.read.dir/build.make
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/debug && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-objdump -Mmarch=IMXpulpv2 -d /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/debug/debug.elf > debug.read
.PHONY : debug.read

# Rule to build all files generated by this target.
apps/riscv_tests/debug/CMakeFiles/debug.read.dir/build: debug.read

.PHONY : apps/riscv_tests/debug/CMakeFiles/debug.read.dir/build

apps/riscv_tests/debug/CMakeFiles/debug.read.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/debug && $(CMAKE_COMMAND) -P CMakeFiles/debug.read.dir/cmake_clean.cmake
.PHONY : apps/riscv_tests/debug/CMakeFiles/debug.read.dir/clean

apps/riscv_tests/debug/CMakeFiles/debug.read.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/riscv_tests/debug /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/debug /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/debug/CMakeFiles/debug.read.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/riscv_tests/debug/CMakeFiles/debug.read.dir/depend
