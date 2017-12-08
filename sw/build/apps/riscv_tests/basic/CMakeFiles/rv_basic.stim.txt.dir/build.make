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

# Utility rule file for rv_basic.stim.txt.

# Include the progress variables for this target.
include apps/riscv_tests/basic/CMakeFiles/rv_basic.stim.txt.dir/progress.make

apps/riscv_tests/basic/CMakeFiles/rv_basic.stim.txt: apps/riscv_tests/basic/vectors/stim.txt


apps/riscv_tests/basic/vectors/stim.txt: apps/riscv_tests/basic/rv_basic.s19
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating vectors/stim.txt"
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/basic && /home/pengfei/artix7-dev/sw/utils/parse_s19.pl ./rv_basic.s19 > ./vectors/stim.txt

apps/riscv_tests/basic/rv_basic.s19: apps/riscv_tests/basic/rv_basic.elf
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating rv_basic.s19"
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/basic && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-objcopy --srec-len 1 --output-target=srec /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/basic/rv_basic.elf rv_basic.s19

rv_basic.stim.txt: apps/riscv_tests/basic/CMakeFiles/rv_basic.stim.txt
rv_basic.stim.txt: apps/riscv_tests/basic/vectors/stim.txt
rv_basic.stim.txt: apps/riscv_tests/basic/rv_basic.s19
rv_basic.stim.txt: apps/riscv_tests/basic/CMakeFiles/rv_basic.stim.txt.dir/build.make

.PHONY : rv_basic.stim.txt

# Rule to build all files generated by this target.
apps/riscv_tests/basic/CMakeFiles/rv_basic.stim.txt.dir/build: rv_basic.stim.txt

.PHONY : apps/riscv_tests/basic/CMakeFiles/rv_basic.stim.txt.dir/build

apps/riscv_tests/basic/CMakeFiles/rv_basic.stim.txt.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/basic && $(CMAKE_COMMAND) -P CMakeFiles/rv_basic.stim.txt.dir/cmake_clean.cmake
.PHONY : apps/riscv_tests/basic/CMakeFiles/rv_basic.stim.txt.dir/clean

apps/riscv_tests/basic/CMakeFiles/rv_basic.stim.txt.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/riscv_tests/basic /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/basic /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/basic/CMakeFiles/rv_basic.stim.txt.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/riscv_tests/basic/CMakeFiles/rv_basic.stim.txt.dir/depend

