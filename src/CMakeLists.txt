#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "GPL-2.0-only WITH GCC-exception-2.0"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
include(cmake/include/option.cmake)
include(cmake/include/process.option.cmake)
include(cmake/include/external.cmake)

add_library(libpaket)
set_target_properties(libpaket PROPERTIES OUTPUT_NAME paket)
add_library(paket::library ALIAS libpaket)

target_include_directories(
  libpaket
  PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>
  $<INSTALL_INTERFACE:include>
  )

target_vanadium_cmake_codegen(
  libpaket
  PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/codegen/cmake
  INSTALL
  )

add_subdirectory(lib)

include(cmake/include/dependency.cmake)
include(cmake/include/install.cmake)
