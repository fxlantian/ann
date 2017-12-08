# Install script for directory: /home/pengfei/artix7-dev/sw/apps/sequential_tests

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/bitDescriptor/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/bubblesort/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fibonacci/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/crc32/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/matrixAdd/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/sudokusolver/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/stencil_vect/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/towerofhanoi/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/matrixMul8/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/matrixMul8_dotp/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/matrixMul16/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/matrixMul16_dotp/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/matrixMul32/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/motion_detection/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/convolution/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/stencil/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fdtd-1d/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/fft/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/dct/cmake_install.cmake")

endif()

