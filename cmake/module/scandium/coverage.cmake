#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
# Option to Compute Coverage
option(ENABLE_COVERAGE "Enable Coverage Instrumentation" OFF)

if(ENABLE_COVERAGE)
  if(TARGET scandium_coverage)
    # This module has already been processed. Don't do it again.
    return()
  endif()
  message(STATUS "Enabling scandium::coverage")
  add_custom_target(scandium_coverage)

  set(
    SCANDIUM_COVERAGE_OUTDIR
    ${PROJECT_BINARY_DIR}/scandium/coverage
    CACHE PATH
    "Path to Store Output of Coverage Data"
    )

  if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    include(${CMAKE_CURRENT_LIST_DIR}/coverage/clang.cmake)
    message(STATUS "Enabling scandium::coverage - Done")
  else()
    message(FATAL_ERROR "Coverage: Unsupported for ${CMAKE_CXX_COMPILER_ID} Compiler.")
  endif()
else()
  include(${CMAKE_CURRENT_LIST_DIR}/coverage/dummy.cmake)
endif()
