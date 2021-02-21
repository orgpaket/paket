#------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#------------------------------------------------------------------------------
get_property(SCANDIUM_ENABLED_LANGUAGE_ARRAY GLOBAL PROPERTY ENABLED_LANGUAGES)
foreach(CEL ${SCANDIUM_ENABLED_LANGUAGE_ARRAY})
  if("${CMAKE_${CEL}_STANDARD}" STREQUAL "")
    message(STATUS "${CEL} Language Standard - Unset")
  else()
    message(STATUS "${CEL} Language Standard - ${CMAKE_${CEL}_STANDARD}")
  endif()

  if("${CMAKE_${CEL}_STANDARD_REQUIRED}" STREQUAL "")
    message(STATUS "${CEL} Standard Required - Unset")
  else()
    message(STATUS "${CEL} Standard Required - ${CMAKE_${CEL}_STANDARD_REQUIRED}")
  endif()

  if("${CMAKE_${CEL}_EXTENSIONS}" STREQUAL "")
    message(STATUS "${CEL} Compiler Extensions - Unset")
  else()
    message(STATUS "${CEL} Compiler Extensions - ${CMAKE_${CEL}_EXTENSIONS}")
  endif()
endforeach()
