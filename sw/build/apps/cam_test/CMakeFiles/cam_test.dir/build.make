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

# Utility rule file for cam_test.

# Include the progress variables for this target.
include apps/cam_test/CMakeFiles/cam_test.dir/progress.make

apps/cam_test/CMakeFiles/cam_test:


cam_test: apps/cam_test/CMakeFiles/cam_test
cam_test: apps/cam_test/CMakeFiles/cam_test.dir/build.make

.PHONY : cam_test

# Rule to build all files generated by this target.
apps/cam_test/CMakeFiles/cam_test.dir/build: cam_test

.PHONY : apps/cam_test/CMakeFiles/cam_test.dir/build

apps/cam_test/CMakeFiles/cam_test.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/cam_test && $(CMAKE_COMMAND) -P CMakeFiles/cam_test.dir/cmake_clean.cmake
.PHONY : apps/cam_test/CMakeFiles/cam_test.dir/clean

apps/cam_test/CMakeFiles/cam_test.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/cam_test /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/cam_test /home/pengfei/artix7-dev/sw/build/apps/cam_test/CMakeFiles/cam_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/cam_test/CMakeFiles/cam_test.dir/depend

