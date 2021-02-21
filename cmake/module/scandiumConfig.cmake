#------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#------------------------------------------------------------------------------
include(CMakePushCheckState)
cmake_push_check_state()

set(CMAKE_REQUIRED_QUIET ${scandium_FIND_QUIETLY})
set(want_components ${scandium_FIND_COMPONENTS})

set(extra_components ${want_components})
list(REMOVE_ITEM extra_components coverage filesystem information )

if(extra_components)
  message(
    FATAL_ERROR
    "Extraneous find_package component for scandium: ${extra_components}"
    )
endif()

if("coverage" IN_LIST want_components)
  include(${CMAKE_CURRENT_LIST_DIR}/scandium/coverage.cmake)
endif()

if("filesystem" IN_LIST want_components)
  include(${CMAKE_CURRENT_LIST_DIR}/scandium/filesystem.cmake)
endif()

if("information" IN_LIST want_components)
  include(${CMAKE_CURRENT_LIST_DIR}/scandium/information.cmake)
endif()

cmake_pop_check_state()
