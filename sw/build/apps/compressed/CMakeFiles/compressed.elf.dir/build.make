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
include apps/compressed/CMakeFiles/compressed.elf.dir/depend.make

# Include the progress variables for this target.
include apps/compressed/CMakeFiles/compressed.elf.dir/progress.make

# Include the compile flags for this target's objects.
include apps/compressed/CMakeFiles/compressed.elf.dir/flags.make

apps/compressed/CMakeFiles/compressed.elf.dir/compressed.S.o: apps/compressed/CMakeFiles/compressed.elf.dir/flags.make
apps/compressed/CMakeFiles/compressed.elf.dir/compressed.S.o: ../apps/compressed/compressed.S
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building ASM object apps/compressed/CMakeFiles/compressed.elf.dir/compressed.S.o"
	cd /home/pengfei/artix7-dev/sw/build/apps/compressed && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -o CMakeFiles/compressed.elf.dir/compressed.S.o -c /home/pengfei/artix7-dev/sw/apps/compressed/compressed.S

apps/compressed/CMakeFiles/compressed.elf.dir/compressed.S.o.requires:

.PHONY : apps/compressed/CMakeFiles/compressed.elf.dir/compressed.S.o.requires

apps/compressed/CMakeFiles/compressed.elf.dir/compressed.S.o.provides: apps/compressed/CMakeFiles/compressed.elf.dir/compressed.S.o.requires
	$(MAKE) -f apps/compressed/CMakeFiles/compressed.elf.dir/build.make apps/compressed/CMakeFiles/compressed.elf.dir/compressed.S.o.provides.build
.PHONY : apps/compressed/CMakeFiles/compressed.elf.dir/compressed.S.o.provides

apps/compressed/CMakeFiles/compressed.elf.dir/compressed.S.o.provides.build: apps/compressed/CMakeFiles/compressed.elf.dir/compressed.S.o


apps/compressed/CMakeFiles/compressed.elf.dir/main.c.o: apps/compressed/CMakeFiles/compressed.elf.dir/flags.make
apps/compressed/CMakeFiles/compressed.elf.dir/main.c.o: ../apps/compressed/main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object apps/compressed/CMakeFiles/compressed.elf.dir/main.c.o"
	cd /home/pengfei/artix7-dev/sw/build/apps/compressed && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/compressed.elf.dir/main.c.o   -c /home/pengfei/artix7-dev/sw/apps/compressed/main.c

apps/compressed/CMakeFiles/compressed.elf.dir/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/compressed.elf.dir/main.c.i"
	cd /home/pengfei/artix7-dev/sw/build/apps/compressed && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pengfei/artix7-dev/sw/apps/compressed/main.c > CMakeFiles/compressed.elf.dir/main.c.i

apps/compressed/CMakeFiles/compressed.elf.dir/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/compressed.elf.dir/main.c.s"
	cd /home/pengfei/artix7-dev/sw/build/apps/compressed && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pengfei/artix7-dev/sw/apps/compressed/main.c -o CMakeFiles/compressed.elf.dir/main.c.s

apps/compressed/CMakeFiles/compressed.elf.dir/main.c.o.requires:

.PHONY : apps/compressed/CMakeFiles/compressed.elf.dir/main.c.o.requires

apps/compressed/CMakeFiles/compressed.elf.dir/main.c.o.provides: apps/compressed/CMakeFiles/compressed.elf.dir/main.c.o.requires
	$(MAKE) -f apps/compressed/CMakeFiles/compressed.elf.dir/build.make apps/compressed/CMakeFiles/compressed.elf.dir/main.c.o.provides.build
.PHONY : apps/compressed/CMakeFiles/compressed.elf.dir/main.c.o.provides

apps/compressed/CMakeFiles/compressed.elf.dir/main.c.o.provides.build: apps/compressed/CMakeFiles/compressed.elf.dir/main.c.o


# Object files for target compressed.elf
compressed_elf_OBJECTS = \
"CMakeFiles/compressed.elf.dir/compressed.S.o" \
"CMakeFiles/compressed.elf.dir/main.c.o"

# External object files for target compressed.elf
compressed_elf_EXTERNAL_OBJECTS = \
"/home/pengfei/artix7-dev/sw/build/CMakeFiles/crt0.dir/ref/crt0.riscv.S.o"

apps/compressed/compressed.elf: apps/compressed/CMakeFiles/compressed.elf.dir/compressed.S.o
apps/compressed/compressed.elf: apps/compressed/CMakeFiles/compressed.elf.dir/main.c.o
apps/compressed/compressed.elf: CMakeFiles/crt0.dir/ref/crt0.riscv.S.o
apps/compressed/compressed.elf: apps/compressed/CMakeFiles/compressed.elf.dir/build.make
apps/compressed/compressed.elf: libs/Arduino_lib/separate_libs/libArduino_separate.a
apps/compressed/compressed.elf: libs/Arduino_lib/core_libs/libArduino_core.a
apps/compressed/compressed.elf: libs/bench_lib/libbench.a
apps/compressed/compressed.elf: libs/string_lib/libstring.a
apps/compressed/compressed.elf: libs/sys_lib/libsys.a
apps/compressed/compressed.elf: apps/compressed/CMakeFiles/compressed.elf.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable compressed.elf"
	cd /home/pengfei/artix7-dev/sw/build/apps/compressed && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/compressed.elf.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
apps/compressed/CMakeFiles/compressed.elf.dir/build: apps/compressed/compressed.elf

.PHONY : apps/compressed/CMakeFiles/compressed.elf.dir/build

apps/compressed/CMakeFiles/compressed.elf.dir/requires: apps/compressed/CMakeFiles/compressed.elf.dir/compressed.S.o.requires
apps/compressed/CMakeFiles/compressed.elf.dir/requires: apps/compressed/CMakeFiles/compressed.elf.dir/main.c.o.requires

.PHONY : apps/compressed/CMakeFiles/compressed.elf.dir/requires

apps/compressed/CMakeFiles/compressed.elf.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/compressed && $(CMAKE_COMMAND) -P CMakeFiles/compressed.elf.dir/cmake_clean.cmake
.PHONY : apps/compressed/CMakeFiles/compressed.elf.dir/clean

apps/compressed/CMakeFiles/compressed.elf.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/compressed /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/compressed /home/pengfei/artix7-dev/sw/build/apps/compressed/CMakeFiles/compressed.elf.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/compressed/CMakeFiles/compressed.elf.dir/depend
