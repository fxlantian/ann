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
include apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/depend.make

# Include the progress variables for this target.
include apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/progress.make

# Include the compile flags for this target's objects.
include apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/flags.make

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/main.c.o: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/flags.make
apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/main.c.o: ../apps/sequential_tests/fft/main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/main.c.o"
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/fft.elf.dir/main.c.o   -c /home/pengfei/artix7-dev/sw/apps/sequential_tests/fft/main.c

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/fft.elf.dir/main.c.i"
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pengfei/artix7-dev/sw/apps/sequential_tests/fft/main.c > CMakeFiles/fft.elf.dir/main.c.i

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/fft.elf.dir/main.c.s"
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pengfei/artix7-dev/sw/apps/sequential_tests/fft/main.c -o CMakeFiles/fft.elf.dir/main.c.s

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/main.c.o.requires:

.PHONY : apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/main.c.o.requires

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/main.c.o.provides: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/main.c.o.requires
	$(MAKE) -f apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/build.make apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/main.c.o.provides.build
.PHONY : apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/main.c.o.provides

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/main.c.o.provides.build: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/main.c.o


apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fft.c.o: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/flags.make
apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fft.c.o: ../apps/sequential_tests/fft/kiss_fft.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fft.c.o"
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/fft.elf.dir/kiss_fft.c.o   -c /home/pengfei/artix7-dev/sw/apps/sequential_tests/fft/kiss_fft.c

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fft.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/fft.elf.dir/kiss_fft.c.i"
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pengfei/artix7-dev/sw/apps/sequential_tests/fft/kiss_fft.c > CMakeFiles/fft.elf.dir/kiss_fft.c.i

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fft.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/fft.elf.dir/kiss_fft.c.s"
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pengfei/artix7-dev/sw/apps/sequential_tests/fft/kiss_fft.c -o CMakeFiles/fft.elf.dir/kiss_fft.c.s

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fft.c.o.requires:

.PHONY : apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fft.c.o.requires

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fft.c.o.provides: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fft.c.o.requires
	$(MAKE) -f apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/build.make apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fft.c.o.provides.build
.PHONY : apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fft.c.o.provides

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fft.c.o.provides.build: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fft.c.o


apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fftr.c.o: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/flags.make
apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fftr.c.o: ../apps/sequential_tests/fft/kiss_fftr.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fftr.c.o"
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/fft.elf.dir/kiss_fftr.c.o   -c /home/pengfei/artix7-dev/sw/apps/sequential_tests/fft/kiss_fftr.c

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fftr.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/fft.elf.dir/kiss_fftr.c.i"
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pengfei/artix7-dev/sw/apps/sequential_tests/fft/kiss_fftr.c > CMakeFiles/fft.elf.dir/kiss_fftr.c.i

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fftr.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/fft.elf.dir/kiss_fftr.c.s"
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pengfei/artix7-dev/sw/apps/sequential_tests/fft/kiss_fftr.c -o CMakeFiles/fft.elf.dir/kiss_fftr.c.s

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fftr.c.o.requires:

.PHONY : apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fftr.c.o.requires

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fftr.c.o.provides: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fftr.c.o.requires
	$(MAKE) -f apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/build.make apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fftr.c.o.provides.build
.PHONY : apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fftr.c.o.provides

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fftr.c.o.provides.build: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fftr.c.o


apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/fft_precomputed.c.o: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/flags.make
apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/fft_precomputed.c.o: ../apps/sequential_tests/fft/fft_precomputed.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/fft_precomputed.c.o"
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/fft.elf.dir/fft_precomputed.c.o   -c /home/pengfei/artix7-dev/sw/apps/sequential_tests/fft/fft_precomputed.c

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/fft_precomputed.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/fft.elf.dir/fft_precomputed.c.i"
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pengfei/artix7-dev/sw/apps/sequential_tests/fft/fft_precomputed.c > CMakeFiles/fft.elf.dir/fft_precomputed.c.i

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/fft_precomputed.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/fft.elf.dir/fft_precomputed.c.s"
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft && /home/pengfei/riscv/ri5cy_gnu_toolchain/install/bin//riscv32-unknown-elf-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pengfei/artix7-dev/sw/apps/sequential_tests/fft/fft_precomputed.c -o CMakeFiles/fft.elf.dir/fft_precomputed.c.s

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/fft_precomputed.c.o.requires:

.PHONY : apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/fft_precomputed.c.o.requires

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/fft_precomputed.c.o.provides: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/fft_precomputed.c.o.requires
	$(MAKE) -f apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/build.make apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/fft_precomputed.c.o.provides.build
.PHONY : apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/fft_precomputed.c.o.provides

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/fft_precomputed.c.o.provides.build: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/fft_precomputed.c.o


# Object files for target fft.elf
fft_elf_OBJECTS = \
"CMakeFiles/fft.elf.dir/main.c.o" \
"CMakeFiles/fft.elf.dir/kiss_fft.c.o" \
"CMakeFiles/fft.elf.dir/kiss_fftr.c.o" \
"CMakeFiles/fft.elf.dir/fft_precomputed.c.o"

# External object files for target fft.elf
fft_elf_EXTERNAL_OBJECTS = \
"/home/pengfei/artix7-dev/sw/build/CMakeFiles/crt0.dir/ref/crt0.riscv.S.o"

apps/sequential_tests/fft/fft.elf: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/main.c.o
apps/sequential_tests/fft/fft.elf: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fft.c.o
apps/sequential_tests/fft/fft.elf: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fftr.c.o
apps/sequential_tests/fft/fft.elf: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/fft_precomputed.c.o
apps/sequential_tests/fft/fft.elf: CMakeFiles/crt0.dir/ref/crt0.riscv.S.o
apps/sequential_tests/fft/fft.elf: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/build.make
apps/sequential_tests/fft/fft.elf: libs/Arduino_lib/separate_libs/libArduino_separate.a
apps/sequential_tests/fft/fft.elf: libs/Arduino_lib/core_libs/libArduino_core.a
apps/sequential_tests/fft/fft.elf: libs/bench_lib/libbench.a
apps/sequential_tests/fft/fft.elf: libs/string_lib/libstring.a
apps/sequential_tests/fft/fft.elf: libs/sys_lib/libsys.a
apps/sequential_tests/fft/fft.elf: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/pengfei/artix7-dev/sw/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CXX executable fft.elf"
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/fft.elf.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/build: apps/sequential_tests/fft/fft.elf

.PHONY : apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/build

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/requires: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/main.c.o.requires
apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/requires: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fft.c.o.requires
apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/requires: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/kiss_fftr.c.o.requires
apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/requires: apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/fft_precomputed.c.o.requires

.PHONY : apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/requires

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/clean:
	cd /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft && $(CMAKE_COMMAND) -P CMakeFiles/fft.elf.dir/cmake_clean.cmake
.PHONY : apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/clean

apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/depend:
	cd /home/pengfei/artix7-dev/sw/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pengfei/artix7-dev/sw /home/pengfei/artix7-dev/sw/apps/sequential_tests/fft /home/pengfei/artix7-dev/sw/build /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft /home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/sequential_tests/fft/CMakeFiles/fft.elf.dir/depend

