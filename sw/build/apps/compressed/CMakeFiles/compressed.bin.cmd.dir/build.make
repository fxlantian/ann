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

# Utility rule file for compressed.bin.cmd.

# Include the progress variables for this target.
include apps/compressed/CMakeFiles/compressed.bin.cmd.dir/progress.make

apps/compressed/CMakeFiles/compressed.bin.cmd: apps/compressed/compressed.bin


apps/compressed/compressed.bin: apps/compressed/compressed.elf
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating compressed.bin"
	cd /home/pengfei/artix7-dev/sw/build/apps/compressed && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-objcopy -R .debug_frame -R .comment -R .stack -R .heapsram -R .heapscm -R .scmlock -O binary /home/pengfei/artix7-dev/sw/build/apps/compressed/compressed.elf compressed.bin

compressed.bin.cmd: apps/compressed/CMakeFiles/compressed.bin.cmd
compressed.bin.cmd: apps/compressed/compressed.bin
compressed.bin.cmd: apps/compressed/CMakeFiles/compressed.bin.cmd.dir/build.make

.PHONY : compressed.bin.cmd

# Rule to build all files generated by this target.
apps/compressed/CMakeFiles/compressed.bin.cmd.dir/build: compressed.bin.cmd

.PHONY : apps/compressed/CMakeFiles/compressed.bin.cmd.dir/build

apps/compressed/CMakeFiles/compressed.bin.cmd.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/compressed && $(CMAKE_COMMAND) -P CMakeFiles/compressed.bin.cmd.dir/cmake_clean.cmake
.PHONY : apps/compressed/CMakeFiles/compressed.bin.cmd.dir/clean

apps/compressed/CMakeFiles/compressed.bin.cmd.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/compressed /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/compressed /home/pengfei/artix7-dev/sw/build/apps/compressed/CMakeFiles/compressed.bin.cmd.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/compressed/CMakeFiles/compressed.bin.cmd.dir/depend

