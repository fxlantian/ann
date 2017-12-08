# Install script for directory: /home/pengfei/artix7-dev/sw/apps

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
  include("/home/pengfei/artix7-dev/sw/build/apps/mem_test/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/testANN/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/cam_test/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/pwm_test/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/helloworld/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/emmc_test/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/bench/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/compressed/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/fpga/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/riscv_tests/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/freertos/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/boot_code/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/sequential_tests/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/imperio_tests/cmake_install.cmake")

endif()

