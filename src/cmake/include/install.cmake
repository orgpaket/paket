#------------------------------------------------------------------------------
# SPDX-License-Identifier: "GPL-2.0-only WITH GCC-exception-2.0"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#------------------------------------------------------------------------------

# Install Targets and Header Files
install(TARGETS libpaket EXPORT paketTarget)

install(
  DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include
  DESTINATION  ${CMAKE_INSTALL_PREFIX}
  )
