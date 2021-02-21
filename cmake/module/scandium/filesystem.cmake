#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
if(TARGET scandium::filesystem)
  return()
endif()

message(STATUS "Checking scandium::filesystem")

include(CMakePushCheckState)
include(CheckIncludeFileCXX)
include(CheckCXXSourceCompiles)

cmake_push_check_state()
set(CMAKE_REQUIRED_QUIET TRUE)
check_include_file_cxx("filesystem" _SCANDIUM_FILESYSTEM_HAVE_HEADER)
mark_as_advanced(_SCANDIUM_FILESYSTEM_HAVE_HEADER)

if(_SCANDIUM_FILESYSTEM_HAVE_HEADER)
  set(find_experimental FALSE)
else()
  set(find_experimental TRUE)
endif()

if(find_experimental)
  check_include_file_cxx(
    "experimental/filesystem"
    _SCANDIUM_FILESYSTEM_HAVE_EXPERIMENTAL_HEADER
    )
  mark_as_advanced(_SCANDIUM_FILESYSTEM_HAVE_EXPERIMENTAL_HEADER)
endif()

if(_SCANDIUM_FILESYSTEM_HAVE_HEADER)
  set(_have_fs TRUE)
  set(_fs_header filesystem)
  set(_fs_namespace std::filesystem)
elseif(_SCANDIUM_FILESYSTEM_HAVE_EXPERIMENTAL_HEADER)
  set(_have_fs TRUE)
  set(_fs_header experimental/filesystem)
  set(_fs_namespace std::experimental::filesystem)
else()
  set(_have_fs FALSE)
endif()

set(SCANDIUM_FILESYSTEM_IS_EXPERIMENTAL
  ${_SCANDIUM_FILESYSTEM_HAVE_EXPERIMENTAL_HEADER}
  CACHE BOOL "TRUE if we have C++ filesystem experimental header"
  )

set(SCANDIUM_FILESYSTEM_HAVE_FS
  ${_have_fs} CACHE BOOL "TRUE if we have the C++ filesystem headers"
  )

set(SCANDIUM_FILESYSTEM_HEADER
  ${_fs_header}
  CACHE STRING "The header that should be included to obtain the filesystem APIs"
  )

set(SCANDIUM_FILESYSTEM_NAMESPACE
  ${_fs_namespace}
  CACHE STRING "The C++ namespace that contains the filesystem APIs"
  )

set(_found FALSE)

if(SCANDIUM_FILESYSTEM_HAVE_FS)
  # We have some filesystem library available. Do link checks
  string(CONFIGURE [[
    #include <@SCANDIUM_FILESYSTEM_HEADER@>

    int main() {
    auto cwd = @SCANDIUM_FILESYSTEM_NAMESPACE@::current_path();
    return static_cast<int>(cwd.string().size());
    }
    ]] code @ONLY)

  # Try to compile a simple filesystem program without any linker flags
  check_cxx_source_compiles("${code}" SCANDIUM_FILESYSTEM_NO_LINK_NEEDED)

  set(can_link ${SCANDIUM_FILESYSTEM_NO_LINK_NEEDED})

  if(NOT SCANDIUM_FILESYSTEM_NO_LINK_NEEDED)
    set(prev_libraries ${CMAKE_REQUIRED_LIBRARIES})
    # Add the libstdc++ flag
    set(CMAKE_REQUIRED_LIBRARIES ${prev_libraries} -lstdc++fs)
    check_cxx_source_compiles("${code}" SCANDIUM_FILESYSTEM_STDCPPFS_NEEDED)
    set(can_link ${SCANDIUM_FILESYSTEM_STDCPPFS_NEEDED})
    if(NOT SCANDIUM_FILESYSTEM_STDCPPFS_NEEDED)
      # Try the libc++ flag
      set(CMAKE_REQUIRED_LIBRARIES ${prev_libraries} -lc++fs)
      check_cxx_source_compiles("${code}" SCANDIUM_FILESYSTEM_CPPFS_NEEDED)
      set(can_link ${SCANDIUM_FILESYSTEM_CPPFS_NEEDED})
    endif()
  endif()

  if(can_link)
    add_library(scandium::filesystem INTERFACE IMPORTED)
    set(_found TRUE)

    if(SCANDIUM_FILESYSTEM_NO_LINK_NEEDED)
      # Nothing to add...
    elseif(SCANDIUM_FILESYSTEM_STDCPPFS_NEEDED)
      target_link_libraries(scandium::filesystem INTERFACE -lstdc++fs)
    elseif(SCANDIUM_FILESYSTEM_CPPFS_NEEDED)
      target_link_libraries(scandium::filesystem INTERFACE -lc++fs)
    endif()
  else()
    set(_found FALSE)
  endif()
endif()
cmake_pop_check_state()

set(scandium::filesystem_FOUND
  ${_found}
  CACHE BOOL "TRUE if we can compile and link a program using scandium::filesystem"
  FORCE
  )

if(scandium::filesystem_FOUND)
  message(STATUS "Checking scandium::filesystem - Success")
else()
  if(SCANDIUM_FILESYSTEM_HAVE_FS)
    message(STATUS "scandium::filesystem: Found Headers - Yes")
  else()
    message(STATUS "scandium::filesystem: Found Headers - NO")
  endif()

  if(SCANDIUM_FILESYSTEM_IS_EXPERIMENTAL)
    message(STATUS "scandium::filesystem: Experimental - Yes")
  else()
    message(STATUS "scandium::filesystem: Experimental - No")
  endif()

  if(NOT SCANDIUM_FILESYSTEM_NO_LINK_NEEDED)
    message(STATUS "scandium::filesystem: Linker Option: None - Failed")
  endif()
  if(NOT SCANDIUM_FILESYSTEM_STDCPPFS_NEEDED)
    message(STATUS "scandium::filesystem: Linker Option: -lstdc++fs - Failed")
  endif()
  if(NOT SCANDIUM_FILESYSTEM_CPPFS_NEEDED)
    message(STATUS "scandium::filesystem: Linker Option: -lc++fs - Failed")
  endif()

  if(scandium_FIND_REQUIRED_filesystem)
    message(FATAL_ERROR "Checking scandium::filesystem - Failed")
  endif()
endif()


