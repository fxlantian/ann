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

# Utility rule file for shift_test.kcg.

# Include the progress variables for this target.
include apps/Arduino_tests/shift_test/CMakeFiles/shift_test.kcg.dir/progress.make

apps/Arduino_tests/shift_test/CMakeFiles/shift_test.kcg:
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/shift_test && pulp-pc-analyze --rtl --input=trace_core_00.log --binary=shift_test.elf
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/shift_test && kcachegrind kcg.txt

shift_test.kcg: apps/Arduino_tests/shift_test/CMakeFiles/shift_test.kcg
shift_test.kcg: apps/Arduino_tests/shift_test/CMakeFiles/shift_test.kcg.dir/build.make

.PHONY : shift_test.kcg

# Rule to build all files generated by this target.
apps/Arduino_tests/shift_test/CMakeFiles/shift_test.kcg.dir/build: shift_test.kcg

.PHONY : apps/Arduino_tests/shift_test/CMakeFiles/shift_test.kcg.dir/build

apps/Arduino_tests/shift_test/CMakeFiles/shift_test.kcg.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/shift_test && $(CMAKE_COMMAND) -P CMakeFiles/shift_test.kcg.dir/cmake_clean.cmake
.PHONY : apps/Arduino_tests/shift_test/CMakeFiles/shift_test.kcg.dir/clean

apps/Arduino_tests/shift_test/CMakeFiles/shift_test.kcg.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/Arduino_tests/shift_test /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/shift_test /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/shift_test/CMakeFiles/shift_test.kcg.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/Arduino_tests/shift_test/CMakeFiles/shift_test.kcg.dir/depend
