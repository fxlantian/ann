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

# Utility rule file for PulseIn_test.links.

# Include the progress variables for this target.
include apps/Arduino_tests/PulseIn_test/CMakeFiles/PulseIn_test.links.dir/progress.make

apps/Arduino_tests/PulseIn_test/CMakeFiles/PulseIn_test.links: apps/Arduino_tests/PulseIn_test/modelsim.ini
apps/Arduino_tests/PulseIn_test/CMakeFiles/PulseIn_test.links: apps/Arduino_tests/PulseIn_test/work
apps/Arduino_tests/PulseIn_test/CMakeFiles/PulseIn_test.links: apps/Arduino_tests/PulseIn_test/tcl_files
apps/Arduino_tests/PulseIn_test/CMakeFiles/PulseIn_test.links: apps/Arduino_tests/PulseIn_test/waves


apps/Arduino_tests/PulseIn_test/modelsim.ini:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating modelsim.ini"
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PulseIn_test && /usr/bin/cmake -E create_symlink /home/pengfei/artix7-dev/vsim/modelsim.ini /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PulseIn_test//modelsim.ini

apps/Arduino_tests/PulseIn_test/work:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating work"
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PulseIn_test && /usr/bin/cmake -E create_symlink /home/pengfei/artix7-dev/vsim/work /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PulseIn_test//work

apps/Arduino_tests/PulseIn_test/tcl_files:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Generating tcl_files"
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PulseIn_test && /usr/bin/cmake -E create_symlink /home/pengfei/artix7-dev/vsim/tcl_files /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PulseIn_test//tcl_files

apps/Arduino_tests/PulseIn_test/waves:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Generating waves"
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PulseIn_test && /usr/bin/cmake -E create_symlink /home/pengfei/artix7-dev/vsim/waves /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PulseIn_test//waves

PulseIn_test.links: apps/Arduino_tests/PulseIn_test/CMakeFiles/PulseIn_test.links
PulseIn_test.links: apps/Arduino_tests/PulseIn_test/modelsim.ini
PulseIn_test.links: apps/Arduino_tests/PulseIn_test/work
PulseIn_test.links: apps/Arduino_tests/PulseIn_test/tcl_files
PulseIn_test.links: apps/Arduino_tests/PulseIn_test/waves
PulseIn_test.links: apps/Arduino_tests/PulseIn_test/CMakeFiles/PulseIn_test.links.dir/build.make

.PHONY : PulseIn_test.links

# Rule to build all files generated by this target.
apps/Arduino_tests/PulseIn_test/CMakeFiles/PulseIn_test.links.dir/build: PulseIn_test.links

.PHONY : apps/Arduino_tests/PulseIn_test/CMakeFiles/PulseIn_test.links.dir/build

apps/Arduino_tests/PulseIn_test/CMakeFiles/PulseIn_test.links.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PulseIn_test && $(CMAKE_COMMAND) -P CMakeFiles/PulseIn_test.links.dir/cmake_clean.cmake
.PHONY : apps/Arduino_tests/PulseIn_test/CMakeFiles/PulseIn_test.links.dir/clean

apps/Arduino_tests/PulseIn_test/CMakeFiles/PulseIn_test.links.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/Arduino_tests/PulseIn_test /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PulseIn_test /home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PulseIn_test/CMakeFiles/PulseIn_test.links.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/Arduino_tests/PulseIn_test/CMakeFiles/PulseIn_test.links.dir/depend

