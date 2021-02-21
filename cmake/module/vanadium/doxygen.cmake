#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
include_guard(GLOBAL)
message(STATUS "Checking vanadium::doxygen  ")
find_package(Doxygen REQUIRED dot)
if(DOXYGEN_FOUND)
  set(DOXYGEN_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/vanadium/documentation/doxygen)
  set(DOXYGEN_ALL_TARGET ALL)
  set(DOXYFILE_IN ${PROJECT_SOURCE_DIR}/cmake/configure/doxyfile.in)
  file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/vanadium/configure/)
  set(DOXYFILE ${PROJECT_BINARY_DIR}/vanadium/configure/Doxyfile)
  configure_file(${DOXYFILE_IN} ${DOXYFILE} @ONLY)

  file(MAKE_DIRECTORY ${DOXYGEN_OUTPUT_DIRECTORY})

  add_custom_target(vanadium_doxygen ${DOXYGEN_ALL_TARGET}
    COMMAND Doxygen::doxygen ${DOXYFILE}
    WORKING_DIRECTORY ${DOXYGEN_OUTPUT_DIRECTORY}
    COMMENT "vanadium::doxygen: Generating API Documentation"
    VERBATIM
    )
  message(STATUS "Checking vanadium::doxygen - Success")
else ()
  message(STATUS "Checking vanadium::doxygen - Failed")
endif()
