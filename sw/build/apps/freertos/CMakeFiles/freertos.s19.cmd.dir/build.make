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

# Utility rule file for freertos.s19.cmd.

# Include the progress variables for this target.
include apps/freertos/CMakeFiles/freertos.s19.cmd.dir/progress.make

apps/freertos/CMakeFiles/freertos.s19.cmd: apps/freertos/freertos.s19


apps/freertos/freertos.s19: apps/freertos/freertos.elf
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating freertos.s19"
	cd /home/pengfei/artix7-dev/sw/build/apps/freertos && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-objcopy --srec-len 1 --output-target=srec /home/pengfei/artix7-dev/sw/build/apps/freertos/freertos.elf freertos.s19

freertos.s19.cmd: apps/freertos/CMakeFiles/freertos.s19.cmd
freertos.s19.cmd: apps/freertos/freertos.s19
freertos.s19.cmd: apps/freertos/CMakeFiles/freertos.s19.cmd.dir/build.make

.PHONY : freertos.s19.cmd

# Rule to build all files generated by this target.
apps/freertos/CMakeFiles/freertos.s19.cmd.dir/build: freertos.s19.cmd

.PHONY : apps/freertos/CMakeFiles/freertos.s19.cmd.dir/build

apps/freertos/CMakeFiles/freertos.s19.cmd.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/freertos && $(CMAKE_COMMAND) -P CMakeFiles/freertos.s19.cmd.dir/cmake_clean.cmake
.PHONY : apps/freertos/CMakeFiles/freertos.s19.cmd.dir/clean

apps/freertos/CMakeFiles/freertos.s19.cmd.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/freertos /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/freertos /home/pengfei/artix7-dev/sw/build/apps/freertos/CMakeFiles/freertos.s19.cmd.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/freertos/CMakeFiles/freertos.s19.cmd.dir/depend
