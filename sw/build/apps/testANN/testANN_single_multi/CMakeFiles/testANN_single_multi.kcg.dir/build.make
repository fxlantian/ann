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

# Utility rule file for testANN_single_multi.kcg.

# Include the progress variables for this target.
include apps/testANN/testANN_single_multi/CMakeFiles/testANN_single_multi.kcg.dir/progress.make

apps/testANN/testANN_single_multi/CMakeFiles/testANN_single_multi.kcg:
	cd /home/pengfei/artix7-dev/sw/build/apps/testANN/testANN_single_multi && pulp-pc-analyze --rtl --input=trace_core_00.log --binary=testANN_single_multi.elf
	cd /home/pengfei/artix7-dev/sw/build/apps/testANN/testANN_single_multi && kcachegrind kcg.txt

testANN_single_multi.kcg: apps/testANN/testANN_single_multi/CMakeFiles/testANN_single_multi.kcg
testANN_single_multi.kcg: apps/testANN/testANN_single_multi/CMakeFiles/testANN_single_multi.kcg.dir/build.make

.PHONY : testANN_single_multi.kcg

# Rule to build all files generated by this target.
apps/testANN/testANN_single_multi/CMakeFiles/testANN_single_multi.kcg.dir/build: testANN_single_multi.kcg

.PHONY : apps/testANN/testANN_single_multi/CMakeFiles/testANN_single_multi.kcg.dir/build

apps/testANN/testANN_single_multi/CMakeFiles/testANN_single_multi.kcg.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/testANN/testANN_single_multi && $(CMAKE_COMMAND) -P CMakeFiles/testANN_single_multi.kcg.dir/cmake_clean.cmake
.PHONY : apps/testANN/testANN_single_multi/CMakeFiles/testANN_single_multi.kcg.dir/clean

apps/testANN/testANN_single_multi/CMakeFiles/testANN_single_multi.kcg.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/testANN/testANN_single_multi /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/testANN/testANN_single_multi /home/pengfei/artix7-dev/sw/build/apps/testANN/testANN_single_multi/CMakeFiles/testANN_single_multi.kcg.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/testANN/testANN_single_multi/CMakeFiles/testANN_single_multi.kcg.dir/depend

