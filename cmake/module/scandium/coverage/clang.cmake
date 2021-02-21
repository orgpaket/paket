#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
add_library(scandium::coverage INTERFACE IMPORTED)
target_compile_options(scandium::coverage INTERFACE "-fprofile-instr-generate")
target_compile_options(scandium::coverage INTERFACE "-fcoverage-mapping")
target_link_options(scandium::coverage INTERFACE "-fprofile-instr-generate")
target_link_options(scandium::coverage INTERFACE "-fcoverage-mapping")

set(SCANDIUM_BINARY_PATH_ARRAY ${CMAKE_SYSTEM_PREFIX_PATH})
list(TRANSFORM SCANDIUM_BINARY_PATH_ARRAY APPEND "/bin")

find_program(
  SCANDIUM_LLVM_PROFDATA
  llvm-profdata
  NO_DEFAULT_PATH
  PATHS ${SCANDIUM_BINARY_PATH_ARRAY}
  DOC "llvm-profdata executable"
  )

find_program(
  SCANDIUM_LLVM_COV
  llvm-cov
  NO_DEFAULT_PATH
  PATHS ${SCANDIUM_BINARY_PATH_ARRAY}
  DOC "llvm-cov executable"
  )

function(scandium_coverage_process_group GROUP_NAME)
  if(NOT TARGET scandium_coverage_${GROUP_NAME})
    message(FATAL_ERROR "Unknown Test Coverage Group: ${GROUP_NAME}")
  endif()

  set(PROFILE_FILE_ARRAY)
  foreach(TEST ${SCANDIUM_COVERAGE_${GROUP_NAME}_TEST_ARRAY})
    list(
      APPEND
      PROFILE_FILE_ARRAY
      "${SCANDIUM_COVERAGE_${GROUP_NAME}_OUTDIR}/prof/${TEST}.prof"
      )
  endforeach()

  set(TARGET_PATH_ARRAY)
  foreach(TARGET ${SCANDIUM_COVERAGE_${GROUP_NAME}_TARGET_ARRAY})
    list(
      APPEND
      TARGET_PATH_ARRAY
      "$<TARGET_FILE:${TARGET}>"
      )
  endforeach()

  add_custom_command(
    OUTPUT ${GROUP_NAME}.profdata
    WORKING_DIRECTORY ${SCANDIUM_COVERAGE_${GROUP_NAME}_OUTDIR}
    COMMAND
    ${SCANDIUM_LLVM_PROFDATA} merge -sparse ${PROFILE_FILE_ARRAY} -o ${GROUP_NAME}.profdata
    DEPENDS ${TARGET_NAME}
    )

  add_custom_command(
    OUTPUT ${GROUP_NAME}.dat
    WORKING_DIRECTORY ${SCANDIUM_COVERAGE_${GROUP_NAME}_OUTDIR}
    COMMAND
    ${SCANDIUM_LLVM_COV} show ${TARGET_PATH_ARRAY} -instr-profile=${GROUP_NAME}.profdata
    -Xdemangler=c++filt
    > ${GROUP_NAME}.dat
    DEPENDS ${GROUP_NAME}.profdata
    )

  add_custom_command(
    OUTPUT ${GROUP_NAME}.json
    WORKING_DIRECTORY ${SCANDIUM_COVERAGE_${GROUP_NAME}_OUTDIR}
    COMMAND
    ${SCANDIUM_LLVM_COV} export ${TARGET_PATH_ARRAY} -instr-profile=${GROUP_NAME}.profdata
    -Xdemangler=c++filt > ${GROUP_NAME}.json
    DEPENDS ${GROUP_NAME}.profdata
    )

  add_custom_command(
    OUTPUT ${GROUP_NAME}.html
    WORKING_DIRECTORY ${SCANDIUM_COVERAGE_${GROUP_NAME}_OUTDIR}
    COMMAND ${SCANDIUM_LLVM_COV} show ${TARGET_PATH_ARRAY}
    -instr-profile=${GROUP_NAME}.profdata
    -Xdemangler=c++filt --format=html -region-coverage-lt=100
    > ${GROUP_NAME}.html
    DEPENDS ${GROUP_NAME}.profdata
    )

  add_custom_target(
    scandium_coverage_${GROUP_NAME}_files
    DEPENDS
    ${GROUP_NAME}.dat
    ${GROUP_NAME}.html
    ${GROUP_NAME}.json
    WORKING_DIRECTORY ${SCANDIUM_COVERAGE_${GROUP_NAME}_OUTDIR}
    )

  add_dependencies(scandium_coverage_${GROUP_NAME} scandium_coverage_${GROUP_NAME}_files)
endfunction()

function(scandium_coverage_initialize_group GROUP_NAME)
  add_custom_target(scandium_coverage_${GROUP_NAME})
  add_dependencies(scandium_coverage scandium_coverage_${GROUP_NAME})


  set(
    SCANDIUM_COVERAGE_${GROUP_NAME}_OUTDIR_LOCAL
    ${SCANDIUM_COVERAGE_OUTDIR}/${GROUP_NAME}
    )

  set(
    SCANDIUM_COVERAGE_${GROUP_NAME}_OUTDIR
    ${SCANDIUM_COVERAGE_${GROUP_NAME}_OUTDIR_LOCAL}
    CACHE INTERNAL "${GROUP_NAME} Output Directory"
    )

  set(
    SCANDIUM_COVERAGE_${GROUP_NAME}_TEST_ARRAY
    CACHE INTERNAL "${GROUP_NAME} Test Array"
    )

  set(
    SCANDIUM_COVERAGE_${GROUP_NAME}_TARGET_ARRAY
    CACHE INTERNAL "${GROUP_NAME} Target Array"
    )

  file(
    MAKE_DIRECTORY
    ${SCANDIUM_COVERAGE_${GROUP_NAME}_OUTDIR_LOCAL}/prof
    )

  cmake_language(EVAL CODE "
  cmake_language(DEFER CALL scandium_coverage_process_group [[${GROUP_NAME}]])
  ")
endfunction()

function(scandium_coverage_register_test GROUP_NAME TEST_NAME TARGET_NAME)
  if(NOT TARGET scandium_coverage_${GROUP_NAME})
    scandium_coverage_initialize_group(${GROUP_NAME})
  endif()

  set_tests_properties(
    ${TEST_NAME}
    PROPERTIES
    ENVIRONMENT
    LLVM_PROFILE_FILE=${SCANDIUM_COVERAGE_${GROUP_NAME}_OUTDIR}/prof/${TEST_NAME}.prof
    )

  list(
    APPEND
    SCANDIUM_COVERAGE_${GROUP_NAME}_TEST_ARRAY
    "${TEST_NAME}"
    )

  set(
    SCANDIUM_COVERAGE_${GROUP_NAME}_TEST_ARRAY
    ${SCANDIUM_COVERAGE_${GROUP_NAME}_TEST_ARRAY}
    CACHE INTERNAL "${GROUP_NAME} Test Array"
    )

  list(
    APPEND
    SCANDIUM_COVERAGE_${GROUP_NAME}_TARGET_ARRAY
    "${TARGET_NAME}"
    )

  set(
    SCANDIUM_COVERAGE_${GROUP_NAME}_TARGET_ARRAY
    ${SCANDIUM_COVERAGE_${GROUP_NAME}_TARGET_ARRAY}
    CACHE INTERNAL "${GROUP_NAME} Test Array"
    )
endfunction()
