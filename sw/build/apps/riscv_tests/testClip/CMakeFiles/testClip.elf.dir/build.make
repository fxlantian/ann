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

# Include any dependencies generated for this target.
include apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/depend.make

# Include the progress variables for this target.
include apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/progress.make

# Include the compile flags for this target's objects.
include apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/flags.make

apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/testClip.c.o: apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/flags.make
apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/testClip.c.o: ../apps/riscv_tests/testClip/testClip.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/testClip.c.o"
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testClip && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/testClip.elf.dir/testClip.c.o   -c /home/pengfei/artix7-dev/sw/apps/riscv_tests/testClip/testClip.c

apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/testClip.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/testClip.elf.dir/testClip.c.i"
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testClip && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pengfei/artix7-dev/sw/apps/riscv_tests/testClip/testClip.c > CMakeFiles/testClip.elf.dir/testClip.c.i

apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/testClip.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/testClip.elf.dir/testClip.c.s"
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testClip && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pengfei/artix7-dev/sw/apps/riscv_tests/testClip/testClip.c -o CMakeFiles/testClip.elf.dir/testClip.c.s

apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/testClip.c.o.requires:

.PHONY : apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/testClip.c.o.requires

apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/testClip.c.o.provides: apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/testClip.c.o.requires
	$(MAKE) -f apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/build.make apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/testClip.c.o.provides.build
.PHONY : apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/testClip.c.o.provides

apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/testClip.c.o.provides.build: apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/testClip.c.o


# Object files for target testClip.elf
testClip_elf_OBJECTS = \
"CMakeFiles/testClip.elf.dir/testClip.c.o"

# External object files for target testClip.elf
testClip_elf_EXTERNAL_OBJECTS = \
"/home/pengfei/artix7-dev/sw/build/CMakeFiles/crt0.dir/ref/crt0.riscv.S.o"

apps/riscv_tests/testClip/testClip.elf: apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/testClip.c.o
apps/riscv_tests/testClip/testClip.elf: CMakeFiles/crt0.dir/ref/crt0.riscv.S.o
apps/riscv_tests/testClip/testClip.elf: apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/build.make
apps/riscv_tests/testClip/testClip.elf: libs/Arduino_lib/separate_libs/libArduino_separate.a
apps/riscv_tests/testClip/testClip.elf: libs/Arduino_lib/core_libs/libArduino_core.a
apps/riscv_tests/testClip/testClip.elf: libs/bench_lib/libbench.a
apps/riscv_tests/testClip/testClip.elf: libs/string_lib/libstring.a
apps/riscv_tests/testClip/testClip.elf: libs/sys_lib/libsys.a
apps/riscv_tests/testClip/testClip.elf: apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable testClip.elf"
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testClip && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/testClip.elf.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/build: apps/riscv_tests/testClip/testClip.elf

.PHONY : apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/build

apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/requires: apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/testClip.c.o.requires

.PHONY : apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/requires

apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testClip && $(CMAKE_COMMAND) -P CMakeFiles/testClip.elf.dir/cmake_clean.cmake
.PHONY : apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/clean

apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/riscv_tests/testClip /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testClip /home/pengfei/artix7-dev/sw/build/apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/riscv_tests/testClip/CMakeFiles/testClip.elf.dir/depend
