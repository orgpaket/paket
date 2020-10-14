#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
find_package(Vanadium REQUIRED COMPONENTS Codegen)
if(ENABLE_DOXYGEN)
  find_package(Vanadium REQUIRED COMPONENTS Doxygen)
endif()
if(ENABLE_COVERAGE)
  find_package(Vanadium REQUIRED COMPONENTS Coverage)
endif()

find_package(Boost REQUIRED)
find_package(lyra REQUIRED)

if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
  find_library(PAKET_LIBDL dl REQUIRED)
  find_library(PAKET_LIBDW dw REQUIRED)
  find_library(PAKET_LIBUNWIND unwind REQUIRED)
endif()
