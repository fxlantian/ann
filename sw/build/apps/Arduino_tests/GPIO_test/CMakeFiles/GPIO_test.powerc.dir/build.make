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

# Utility rule file for GPIO_test.powerc.

# Include the progress variables for this target.
include apps/Arduino_tests/GPIO_test/CMakeFiles/GPIO_test.powerc.dir/progress.make

apps/Arduino_tests/GPIO_test/CMakeFiles/GPIO_test.powerc:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Running GPIO_test in ModelSim (post layout)"
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/GPIO_test && /usr/bin/cmake -E remove stdout/*
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/GPIO_test && /usr/bin/cmake -E remove FS/*
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/GPIO_test && tcsh -c env\ PPU_CORE=riscv\ VSIM_DIR=/home/pengfei/artix7-dev/vsim\ TB_TEST="ARDUINO_GPIO"\ /opt/modeltech/linux_x86_64/vsim\ \ -c\ -64\ -do\ 'source\ tcl_files/run_power.tcl\;\ run\ -a\;\ exit'

GPIO_test.powerc: apps/Arduino_tests/GPIO_test/CMakeFiles/GPIO_test.powerc
GPIO_test.powerc: apps/Arduino_tests/GPIO_test/CMakeFiles/GPIO_test.powerc.dir/build.make

.PHONY : GPIO_test.powerc

# Rule to build all files generated by this target.
apps/Arduino_tests/GPIO_test/CMakeFiles/GPIO_test.powerc.dir/build: GPIO_test.powerc

.PHONY : apps/Arduino_tests/GPIO_test/CMakeFiles/GPIO_test.powerc.dir/build

apps/Arduino_tests/GPIO_test/CMakeFiles/GPIO_test.powerc.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/GPIO_test && $(CMAKE_COMMAND) -P CMakeFiles/GPIO_test.powerc.dir/cmake_clean.cmake
.PHONY : apps/Arduino_tests/GPIO_test/CMakeFiles/GPIO_test.powerc.dir/clean

apps/Arduino_tests/GPIO_test/CMakeFiles/GPIO_test.powerc.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/Arduino_tests/GPIO_test /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/GPIO_test /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/GPIO_test/CMakeFiles/GPIO_test.powerc.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/Arduino_tests/GPIO_test/CMakeFiles/GPIO_test.powerc.dir/depend

