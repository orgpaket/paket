#------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#------------------------------------------------------------------------------

set(VANADIUM_ENABLE_HUMAN_NAME "Enable")
set(VANADIUM_DISABLE_HUMAN_NAME "Disable")

function(vanadium_mode_register MODE_NAME MODE_HUMAN_NAME MODE_OPTION_ARRAY ENABLE_ARRAY DISABLE_ARRAY)
  set(${MODE_NAME}_OPTION_ARRAY "${MODE_OPTION_ARRAY}")
  set(ENABLE_${MODE_NAME} "${ENABLE_ARRAY}" CACHE STRING "List of enabled ${MODE_HUMAN_NAME}s" )
  set(DISABLE_${MODE_NAME} "${DISABLE_ARRAY}" CACHE STRING "List of disabled ${MODE_HUMAN_NAME}s" )
  set(${MODE_NAME}_OPTION_ARRAY "${MODE_OPTION_ARRAY}" PARENT_SCOPE)
  set(${MODE_NAME}_HUMAN_NAME ${MODE_HUMAN_NAME} PARENT_SCOPE)
endfunction()

function(vanadium_mode_ensure_exclusive EXCLUSIVE_MODE OPTION_ED MODE_NAME)
  if(${OPTION_ED}_${MODE_NAME})
    if(${EXCLUSIVE_MODE} IN_LIST ${OPTION_ED}_${MODE_NAME})
      list(LENGTH ${OPTION_ED}_${MODE_NAME} LIST_LENGTH)
      if(NOT ${LIST_LENGTH} EQUAL 1)
        message(FATAL_ERROR "
        ${${MODE_NAME}_HUMAN_NAME}s ${VANADIUM_${OPTION_ED}_HUMAN_NAME}d: ${${OPTION_ED}_${MODE_NAME}}
        No other ${${MODE_NAME}_HUMAN_NAME} can be ${VANADIUM_${OPTION_ED}_HUMAN_NAME}d along with ${EXCLUSIVE_MODE}.
        ")
      endif()
    endif()
  endif()
endfunction()

function(vanadium_mode_ensure_exclusive_whole MODE_NAME)
  vanadium_mode_ensure_exclusive(None ENABLE ${MODE_NAME})
  vanadium_mode_ensure_exclusive(None DISABLE ${MODE_NAME})
  vanadium_mode_ensure_exclusive(All ENABLE ${MODE_NAME})
  vanadium_mode_ensure_exclusive(All DISABLE ${MODE_NAME})
endfunction()

function(vanadium_mode_ensure_no_conflict MODE_NAME)
  foreach(ENABLED_MODE ${ENABLE_${MODE_NAME}})
    foreach(DISABLED_MODE ${DISABLE_${MODE_NAME}})
      if(${ENABLED_MODE} STREQUAL ${DISABLED_MODE})
        message(FATAL_ERROR "
        Inconsistent specification of ${${MODE_NAME}_HUMAN_NAME}: ${ENABLED_MODE}
        The ${${MODE_NAME}_HUMAN_NAME} is specified in both ENABLE_${MODE_NAME} and DISABLE_${MODE_NAME}.
        A ${${MODE_NAME}_HUMAN_NAME} can either be enabled or disabled, but not both.
        ")
      endif()
    endforeach()
  endforeach()
endfunction()

function(vanadium_mode_conditionally_populate MODE_NAME)
  if(ENABLE_${MODE_NAME})
    list(LENGTH ENABLE_${MODE_NAME} LIST_LENGTH)
    if(${LIST_LENGTH} STREQUAL 1)
      if(${ENABLE_${MODE_NAME}} STREQUAL "All")
        set(ENABLE_${MODE_NAME} ${${MODE_NAME}_OPTION_ARRAY} PARENT_SCOPE)
      endif()

      if(${ENABLE_${MODE_NAME}} STREQUAL "None")
        set(ENABLE_${MODE_NAME} "" PARENT_SCOPE)
      endif()
    endif()
  endif()

  if(DISABLE_${MODE_NAME})
    list(LENGTH ENABLE_${MODE_NAME} LIST_LENGTH)
    if(${LIST_LENGTH} STREQUAL 1)
      if(${DISABLE_${MODE_NAME}} STREQUAL "All")
        set(DISABLE_${MODE_NAME} ${${MODE_NAME}_OPTION_ARRAY} PARENT_SCOPE)
      endif()

      if(${DISABLE_${MODE_NAME}} STREQUAL "None")
        set(DISABLE_${MODE_NAME} "" PARENT_SCOPE)
      endif()
    endif()
  endif()
endfunction()

function(vanadium_mode_populate MODE_NAME)
  set(${MODE_NAME}_ARRAY "${ENABLE_${MODE_NAME}}")
  foreach(DISABLED_MODE ${DISABLE_${MODE_NAME}})
    list(REMOVE_ITEM ${MODE_NAME}_ARRAY ${DISABLED_MODE})
  endforeach()
  set(${MODE_NAME}_ARRAY ${${MODE_NAME}_ARRAY} PARENT_SCOPE)
endfunction()

function(vanadium_mode_check_validity MODE_NAME)
  foreach(DISABLED_MODE ${DISABLE_${MODE_NAME}})
    if(NOT ${DISABLED_MODE} IN_LIST ${MODE_NAME}_OPTION_ARRAY)
      if(NOT ${DISABLED_MODE} STREQUAL "All")
        if(NOT ${DISABLED_MODE} STREQUAL "None")
          message(FATAL_ERROR "
          Invalid value passed to DISABLE_${MODE_NAME} : ${DISABLED_MODE}
          Valid values are: ${${MODE_NAME}_OPTION_ARRAY}
          ")
        endif()
      endif()
    endif()
  endforeach()

  foreach(ENABLED_MODE ${ENABLE_${MODE_NAME}})
    if(NOT ${ENABLED_MODE} IN_LIST ${MODE_NAME}_OPTION_ARRAY)
      message(FATAL_ERROR "
      Invalid value passed to ENABLE_${MODE_NAME} : ${ENABLED_MODE}
      Valid values are: ${${MODE_NAME}_OPTION_ARRAY}
      ")
    endif()
  endforeach()
endfunction()

function(vanadium_mode_process MODE_NAME)
  vanadium_mode_check_validity(${MODE_NAME})
  vanadium_mode_ensure_exclusive_whole(${MODE_NAME})
  vanadium_mode_ensure_no_conflict(${MODE_NAME})
  vanadium_mode_conditionally_populate(${MODE_NAME})
  vanadium_mode_populate(${MODE_NAME})
  set(${MODE_NAME}_ARRAY ${${MODE_NAME}_ARRAY} PARENT_SCOPE)
  message(STATUS "List of ${${MODE_NAME}_HUMAN_NAME} enabled: ${${MODE_NAME}_ARRAY}")
endfunction()
