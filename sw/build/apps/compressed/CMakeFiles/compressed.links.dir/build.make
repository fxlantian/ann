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

# Utility rule file for compressed.links.

# Include the progress variables for this target.
include apps/compressed/CMakeFiles/compressed.links.dir/progress.make

apps/compressed/CMakeFiles/compressed.links: apps/compressed/modelsim.ini
apps/compressed/CMakeFiles/compressed.links: apps/compressed/work
apps/compressed/CMakeFiles/compressed.links: apps/compressed/tcl_files
apps/compressed/CMakeFiles/compressed.links: apps/compressed/waves


apps/compressed/modelsim.ini:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating modelsim.ini"
	cd /home/pengfei/artix7-dev/sw/build/apps/compressed && /usr/bin/cmake -E create_symlink /home/pengfei/artix7-dev/vsim/modelsim.ini /home/pengfei/artix7-dev/sw/build/apps/compressed//modelsim.ini

apps/compressed/work:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating work"
	cd /home/pengfei/artix7-dev/sw/build/apps/compressed && /usr/bin/cmake -E create_symlink /home/pengfei/artix7-dev/vsim/work /home/pengfei/artix7-dev/sw/build/apps/compressed//work

apps/compressed/tcl_files:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Generating tcl_files"
	cd /home/pengfei/artix7-dev/sw/build/apps/compressed && /usr/bin/cmake -E create_symlink /home/pengfei/artix7-dev/vsim/tcl_files /home/pengfei/artix7-dev/sw/build/apps/compressed//tcl_files

apps/compressed/waves:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Generating waves"
	cd /home/pengfei/artix7-dev/sw/build/apps/compressed && /usr/bin/cmake -E create_symlink /home/pengfei/artix7-dev/vsim/waves /home/pengfei/artix7-dev/sw/build/apps/compressed//waves

compressed.links: apps/compressed/CMakeFiles/compressed.links
compressed.links: apps/compressed/modelsim.ini
compressed.links: apps/compressed/work
compressed.links: apps/compressed/tcl_files
compressed.links: apps/compressed/waves
compressed.links: apps/compressed/CMakeFiles/compressed.links.dir/build.make

.PHONY : compressed.links

# Rule to build all files generated by this target.
apps/compressed/CMakeFiles/compressed.links.dir/build: compressed.links

.PHONY : apps/compressed/CMakeFiles/compressed.links.dir/build

apps/compressed/CMakeFiles/compressed.links.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/compressed && $(CMAKE_COMMAND) -P CMakeFiles/compressed.links.dir/cmake_clean.cmake
.PHONY : apps/compressed/CMakeFiles/compressed.links.dir/clean

apps/compressed/CMakeFiles/compressed.links.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/compressed /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/compressed /home/pengfei/artix7-dev/sw/build/apps/compressed/CMakeFiles/compressed.links.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/compressed/CMakeFiles/compressed.links.dir/depend
