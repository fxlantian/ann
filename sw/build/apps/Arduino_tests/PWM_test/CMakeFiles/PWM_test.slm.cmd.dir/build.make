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

# Utility rule file for PWM_test.slm.cmd.

# Include the progress variables for this target.
include apps/Arduino_tests/PWM_test/CMakeFiles/PWM_test.slm.cmd.dir/progress.make

apps/Arduino_tests/PWM_test/CMakeFiles/PWM_test.slm.cmd: apps/Arduino_tests/PWM_test/slm_files/l2_ram.slm


apps/Arduino_tests/PWM_test/slm_files/l2_ram.slm: apps/Arduino_tests/PWM_test/PWM_test.s19
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating slm_files/l2_ram.slm"
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PWM_test/slm_files && /home/pengfei/artix7-dev/sw/utils/s19toslm.py ../PWM_test.s19
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PWM_test/slm_files && /usr/bin/cmake -E touch l2_ram.slm

apps/Arduino_tests/PWM_test/PWM_test.s19: apps/Arduino_tests/PWM_test/PWM_test.elf
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating PWM_test.s19"
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PWM_test && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-objcopy --srec-len 1 --output-target=srec /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PWM_test/PWM_test.elf PWM_test.s19

PWM_test.slm.cmd: apps/Arduino_tests/PWM_test/CMakeFiles/PWM_test.slm.cmd
PWM_test.slm.cmd: apps/Arduino_tests/PWM_test/slm_files/l2_ram.slm
PWM_test.slm.cmd: apps/Arduino_tests/PWM_test/PWM_test.s19
PWM_test.slm.cmd: apps/Arduino_tests/PWM_test/CMakeFiles/PWM_test.slm.cmd.dir/build.make

.PHONY : PWM_test.slm.cmd

# Rule to build all files generated by this target.
apps/Arduino_tests/PWM_test/CMakeFiles/PWM_test.slm.cmd.dir/build: PWM_test.slm.cmd

.PHONY : apps/Arduino_tests/PWM_test/CMakeFiles/PWM_test.slm.cmd.dir/build

apps/Arduino_tests/PWM_test/CMakeFiles/PWM_test.slm.cmd.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PWM_test && $(CMAKE_COMMAND) -P CMakeFiles/PWM_test.slm.cmd.dir/cmake_clean.cmake
.PHONY : apps/Arduino_tests/PWM_test/CMakeFiles/PWM_test.slm.cmd.dir/clean

apps/Arduino_tests/PWM_test/CMakeFiles/PWM_test.slm.cmd.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/Arduino_tests/PWM_test /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PWM_test /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PWM_test/CMakeFiles/PWM_test.slm.cmd.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/Arduino_tests/PWM_test/CMakeFiles/PWM_test.slm.cmd.dir/depend

