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

# Utility rule file for testEvents.annotate.

# Include the progress variables for this target.
include apps/riscv_tests/testEvents/CMakeFiles/testEvents.annotate.dir/progress.make

testEvents.annotate: apps/riscv_tests/testEvents/CMakeFiles/testEvents.annotate.dir/build.make
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testEvents && /home/pengfei/artix7-dev/sw/utils/annotate.py testEvents.read
.PHONY : testEvents.annotate

# Rule to build all files generated by this target.
apps/riscv_tests/testEvents/CMakeFiles/testEvents.annotate.dir/build: testEvents.annotate

.PHONY : apps/riscv_tests/testEvents/CMakeFiles/testEvents.annotate.dir/build

apps/riscv_tests/testEvents/CMakeFiles/testEvents.annotate.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testEvents && $(CMAKE_COMMAND) -P CMakeFiles/testEvents.annotate.dir/cmake_clean.cmake
.PHONY : apps/riscv_tests/testEvents/CMakeFiles/testEvents.annotate.dir/clean

apps/riscv_tests/testEvents/CMakeFiles/testEvents.annotate.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/riscv_tests/testEvents /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testEvents /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testEvents/CMakeFiles/testEvents.annotate.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/riscv_tests/testEvents/CMakeFiles/testEvents.annotate.dir/depend

