#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "GPL-2.0-only WITH GCC-exception-2.0"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
target_link_libraries(libtest PUBLIC paket::library)
if(ENABLE_COVERAGE)
  target_link_libraries(libtest PUBLIC scandium::coverage)
endif()
target_link_libraries(libtest PUBLIC Catch2::Catch2)
target_link_libraries(libtest PUBLIC scandium::filesystem)
