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

# Utility rule file for sudokusolver.read.

# Include the progress variables for this target.
include apps/sequential_tests/sudokusolver/CMakeFiles/sudokusolver.read.dir/progress.make

sudokusolver.read: apps/sequential_tests/sudokusolver/CMakeFiles/sudokusolver.read.dir/build.make
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/sudokusolver && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-objdump -Mmarch=IMXpulpv2 -d /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/sudokusolver/sudokusolver.elf > sudokusolver.read
.PHONY : sudokusolver.read

# Rule to build all files generated by this target.
apps/sequential_tests/sudokusolver/CMakeFiles/sudokusolver.read.dir/build: sudokusolver.read

.PHONY : apps/sequential_tests/sudokusolver/CMakeFiles/sudokusolver.read.dir/build

apps/sequential_tests/sudokusolver/CMakeFiles/sudokusolver.read.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/sudokusolver && $(CMAKE_COMMAND) -P CMakeFiles/sudokusolver.read.dir/cmake_clean.cmake
.PHONY : apps/sequential_tests/sudokusolver/CMakeFiles/sudokusolver.read.dir/clean

apps/sequential_tests/sudokusolver/CMakeFiles/sudokusolver.read.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/sequential_tests/sudokusolver /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/sudokusolver /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/sudokusolver/CMakeFiles/sudokusolver.read.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/sequential_tests/sudokusolver/CMakeFiles/sudokusolver.read.dir/depend

