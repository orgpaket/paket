#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "GPL-2.0-only WITH GCC-exception-2.0"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.19)
project(
  paket
  VERSION 0.0.0.0
  DESCRIPTION "paket"
  LANGUAGES CXX
  HOMEPAGE_URL "https://github.com/orgpaket/paket"
  )
include(cmake/include/option.cmake)
include(cmake/include/system.cmake)

include(cmake/include/process.option.cmake)

add_subdirectory(src)

if(BUILD_TESTING)
  add_subdirectory(test)
endif()
