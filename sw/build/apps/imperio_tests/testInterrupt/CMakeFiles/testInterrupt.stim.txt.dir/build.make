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

# Utility rule file for testInterrupt.stim.txt.

# Include the progress variables for this target.
include apps/imperio_tests/testInterrupt/CMakeFiles/testInterrupt.stim.txt.dir/progress.make

apps/imperio_tests/testInterrupt/CMakeFiles/testInterrupt.stim.txt: apps/imperio_tests/testInterrupt/vectors/stim.txt


apps/imperio_tests/testInterrupt/vectors/stim.txt: apps/imperio_tests/testInterrupt/testInterrupt.s19
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating vectors/stim.txt"
	cd /home/pengfei/artix7-dev/sw/build/apps/imperio_tests/testInterrupt && /home/pengfei/artix7-dev/sw/utils/parse_s19.pl ./testInterrupt.s19 > ./vectors/stim.txt

apps/imperio_tests/testInterrupt/testInterrupt.s19: apps/imperio_tests/testInterrupt/testInterrupt.elf
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating testInterrupt.s19"
	cd /home/pengfei/artix7-dev/sw/build/apps/imperio_tests/testInterrupt && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-objcopy --srec-len 1 --output-target=srec /home/pengfei/artix7-dev/sw/build/apps/imperio_tests/testInterrupt/testInterrupt.elf testInterrupt.s19

testInterrupt.stim.txt: apps/imperio_tests/testInterrupt/CMakeFiles/testInterrupt.stim.txt
testInterrupt.stim.txt: apps/imperio_tests/testInterrupt/vectors/stim.txt
testInterrupt.stim.txt: apps/imperio_tests/testInterrupt/testInterrupt.s19
testInterrupt.stim.txt: apps/imperio_tests/testInterrupt/CMakeFiles/testInterrupt.stim.txt.dir/build.make

.PHONY : testInterrupt.stim.txt

# Rule to build all files generated by this target.
apps/imperio_tests/testInterrupt/CMakeFiles/testInterrupt.stim.txt.dir/build: testInterrupt.stim.txt

.PHONY : apps/imperio_tests/testInterrupt/CMakeFiles/testInterrupt.stim.txt.dir/build

apps/imperio_tests/testInterrupt/CMakeFiles/testInterrupt.stim.txt.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/imperio_tests/testInterrupt && $(CMAKE_COMMAND) -P CMakeFiles/testInterrupt.stim.txt.dir/cmake_clean.cmake
.PHONY : apps/imperio_tests/testInterrupt/CMakeFiles/testInterrupt.stim.txt.dir/clean

apps/imperio_tests/testInterrupt/CMakeFiles/testInterrupt.stim.txt.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/imperio_tests/testInterrupt /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/imperio_tests/testInterrupt /home/pengfei/artix7-dev/sw/build/apps/imperio_tests/testInterrupt/CMakeFiles/testInterrupt.stim.txt.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/imperio_tests/testInterrupt/CMakeFiles/testInterrupt.stim.txt.dir/depend

