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

# Utility rule file for perfbench.aes_cbc.vsimc.

# Include the progress variables for this target.
include apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.vsimc.dir/progress.make

apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.vsimc:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Running perfbench.aes_cbc in ModelSim"
	cd /home/pengfei/artix7-dev/sw/build/apps/bench/aes_cbc && /usr/bin/cmake -E remove stdout/*
	cd /home/pengfei/artix7-dev/sw/build/apps/bench/aes_cbc && /usr/bin/cmake -E remove FS/*
	cd /home/pengfei/artix7-dev/sw/build/apps/bench/aes_cbc && tcsh -c env\ PPU_CORE=riscv\ VSIM_DIR=/home/pengfei/artix7-dev/vsim\ TB_TEST=""\ /opt/modeltech/linux_x86_64/vsim\ \ -c\ -64\ -do\ 'source\ tcl_files/run.tcl\;\ run\ -a\;\ exit\;'\ 
	cd /home/pengfei/artix7-dev/sw/build/apps/bench/aes_cbc && tail -n +1 -- ./stdout/*

perfbench.aes_cbc.vsimc: apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.vsimc
perfbench.aes_cbc.vsimc: apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.vsimc.dir/build.make

.PHONY : perfbench.aes_cbc.vsimc

# Rule to build all files generated by this target.
apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.vsimc.dir/build: perfbench.aes_cbc.vsimc

.PHONY : apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.vsimc.dir/build

apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.vsimc.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/bench/aes_cbc && $(CMAKE_COMMAND) -P CMakeFiles/perfbench.aes_cbc.vsimc.dir/cmake_clean.cmake
.PHONY : apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.vsimc.dir/clean

apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.vsimc.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/bench/aes_cbc /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/bench/aes_cbc /home/pengfei/artix7-dev/sw/build/apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.vsimc.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/bench/aes_cbc/CMakeFiles/perfbench.aes_cbc.vsimc.dir/depend

