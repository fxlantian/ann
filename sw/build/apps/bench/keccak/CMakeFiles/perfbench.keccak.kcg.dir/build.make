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

# Utility rule file for perfbench.keccak.kcg.

# Include the progress variables for this target.
include apps/bench/keccak/CMakeFiles/perfbench.keccak.kcg.dir/progress.make

apps/bench/keccak/CMakeFiles/perfbench.keccak.kcg:
	cd /home/pengfei/artix7-dev/sw/build/apps/bench/keccak && pulp-pc-analyze --rtl --input=trace_core_00.log --binary=perfbench.keccak.elf
	cd /home/pengfei/artix7-dev/sw/build/apps/bench/keccak && kcachegrind kcg.txt

perfbench.keccak.kcg: apps/bench/keccak/CMakeFiles/perfbench.keccak.kcg
perfbench.keccak.kcg: apps/bench/keccak/CMakeFiles/perfbench.keccak.kcg.dir/build.make

.PHONY : perfbench.keccak.kcg

# Rule to build all files generated by this target.
apps/bench/keccak/CMakeFiles/perfbench.keccak.kcg.dir/build: perfbench.keccak.kcg

.PHONY : apps/bench/keccak/CMakeFiles/perfbench.keccak.kcg.dir/build

apps/bench/keccak/CMakeFiles/perfbench.keccak.kcg.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/bench/keccak && $(CMAKE_COMMAND) -P CMakeFiles/perfbench.keccak.kcg.dir/cmake_clean.cmake
.PHONY : apps/bench/keccak/CMakeFiles/perfbench.keccak.kcg.dir/clean

apps/bench/keccak/CMakeFiles/perfbench.keccak.kcg.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/bench/keccak /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/bench/keccak /home/pengfei/artix7-dev/sw/build/apps/bench/keccak/CMakeFiles/perfbench.keccak.kcg.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/bench/keccak/CMakeFiles/perfbench.keccak.kcg.dir/depend

