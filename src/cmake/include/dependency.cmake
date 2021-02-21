#------------------------------------------------------------------------------
# SPDX-License-Identifier: "GPL-2.0-only WITH GCC-exception-2.0"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#------------------------------------------------------------------------------
if(ENABLE_COVERAGE)
  target_link_libraries(libpaket PUBLIC scandium::coverage)
endif()
