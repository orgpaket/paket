#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
target_link_libraries(${LIBNAME} PUBLIC Boost::boost)
target_link_libraries(${LIBNAME} PUBLIC bfg::lyra)

if(ENABLE_BACKTRACE)
  if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
    target_link_libraries(${LIBNAME} PUBLIC dl)
    target_link_libraries(${LIBNAME} PUBLIC dw)
    target_link_libraries(${LIBNAME} PUBLIC unwind)
  endif()
endif()
