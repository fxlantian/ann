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

# Utility rule file for boot_code.install.

# Include the progress variables for this target.
include apps/boot_code/CMakeFiles/boot_code.install.dir/progress.make

apps/boot_code/CMakeFiles/boot_code.install: apps/boot_code/boot/boot_code.sv
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Copying boot code..."
	cd /home/pengfei/artix7-dev/sw/build/apps/boot_code && cp boot/boot_code.sv /home/pengfei/artix7-dev/sw/../rtl/core/

apps/boot_code/boot/boot_code.sv: apps/boot_code/boot_code.s19
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating boot/boot_code.sv"
	cd /home/pengfei/artix7-dev/sw/build/apps/boot_code/boot && /home/pengfei/artix7-dev/sw/utils/s19toboot.py ../boot_code.s19

apps/boot_code/boot_code.s19: apps/boot_code/boot_code.elf
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Generating boot_code.s19"
	cd /home/pengfei/artix7-dev/sw/build/apps/boot_code && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-objcopy --srec-len 1 --output-target=srec /home/pengfei/artix7-dev/sw/build/apps/boot_code/boot_code.elf boot_code.s19

boot_code.install: apps/boot_code/CMakeFiles/boot_code.install
boot_code.install: apps/boot_code/boot/boot_code.sv
boot_code.install: apps/boot_code/boot_code.s19
boot_code.install: apps/boot_code/CMakeFiles/boot_code.install.dir/build.make

.PHONY : boot_code.install

# Rule to build all files generated by this target.
apps/boot_code/CMakeFiles/boot_code.install.dir/build: boot_code.install

.PHONY : apps/boot_code/CMakeFiles/boot_code.install.dir/build

apps/boot_code/CMakeFiles/boot_code.install.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/boot_code && $(CMAKE_COMMAND) -P CMakeFiles/boot_code.install.dir/cmake_clean.cmake
.PHONY : apps/boot_code/CMakeFiles/boot_code.install.dir/clean

apps/boot_code/CMakeFiles/boot_code.install.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/boot_code /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/boot_code /home/pengfei/artix7-dev/sw/build/apps/boot_code/CMakeFiles/boot_code.install.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/boot_code/CMakeFiles/boot_code.install.dir/depend

