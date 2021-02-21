#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
include(CMakePushCheckState)
cmake_push_check_state()

set(CMAKE_REQUIRED_QUIET ${vanadium_FIND_QUIETLY})
set(want_components ${vanadium_FIND_COMPONENTS})

set(extra_components ${want_components})
list(REMOVE_ITEM extra_components codegen doxygen mode)

foreach(component IN LISTS extra_components)
  message(FATAL_ERROR "Extraneous find_package component for vanadium: ${component}")
endforeach()

if("codegen" IN_LIST want_components)
  include(${CMAKE_CURRENT_LIST_DIR}/vanadium/codegen.cmake)
endif()

if("doxygen" IN_LIST want_components)
  include(${CMAKE_CURRENT_LIST_DIR}/vanadium/doxygen.cmake)
endif()

if("mode" IN_LIST want_components)
  include(${CMAKE_CURRENT_LIST_DIR}/vanadium/mode.cmake)
endif()

cmake_pop_check_state()
