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

# Utility rule file for vcompile.core.

# Include the progress variables for this target.
include CMakeFiles/vcompile.core.dir/progress.make

CMakeFiles/vcompile.core:
	cd /home/pengfei/artix7-dev/vsim && tcsh ./vcompile/vcompile_riscv.csh

vcompile.core: CMakeFiles/vcompile.core
vcompile.core: CMakeFiles/vcompile.core.dir/build.make

.PHONY : vcompile.core

# Rule to build all files generated by this target.
CMakeFiles/vcompile.core.dir/build: vcompile.core

.PHONY : CMakeFiles/vcompile.core.dir/build

CMakeFiles/vcompile.core.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/vcompile.core.dir/cmake_clean.cmake
.PHONY : CMakeFiles/vcompile.core.dir/clean

CMakeFiles/vcompile.core.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/CMakeFiles/vcompile.core.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/vcompile.core.dir/depend

