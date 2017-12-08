# Install script for directory: /home/pengfei/artix7-dev/sw/apps/Arduino_tests

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
  include("/home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/GPIO_test/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/int_test/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/timer_test/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PWM_test/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/UART_test/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/PulseIn_test/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/shift_test/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/wire_test/cmake_install.cmake")
  include("/home/pengfei/artix7-dev/sw/build/apps/Arduino_tests/SPI_test/cmake_install.cmake")

endif()

