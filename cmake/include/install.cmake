#------------------------------------------------------------------------------
# SPDX-License-Identifier: "GPL-2.0-only WITH GCC-exception-2.0"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#------------------------------------------------------------------------------

include(GNUInstallDirs)

# Write Project Version Information
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  ${PROJECT_BINARY_DIR}/paketConfigVersion.cmake
  VERSION ${CMAKE_PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
  )

install(
  FILES
  ${PROJECT_BINARY_DIR}/paketConfig.cmake
  ${PROJECT_BINARY_DIR}/paketConfigVersion.cmake
  DESTINATION ${CMAKE_INSTALL_DATADIR}/paket/cmake/
  )

# Generate paketConfig.cmake file
configure_package_config_file(
  ${PROJECT_SOURCE_DIR}/cmake/configure/paketConfig.cmake.in
  ${PROJECT_BINARY_DIR}/paketConfig.cmake
  INSTALL_DESTINATION ${CMAKE_INSTALL_DATADIR}/paket
  )


install(
  EXPORT paketTarget
  FILE  paketTarget.cmake
  NAMESPACE paket::
  DESTINATION ${CMAKE_INSTALL_DATADIR}/paket/cmake
  )


# Install License
install(
  FILES
  ${PROJECT_SOURCE_DIR}/license
  DESTINATION  ${CMAKE_INSTALL_DATADIR}/licenses/paket/
  )

