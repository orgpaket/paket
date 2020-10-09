#------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#------------------------------------------------------------------------------
add_executable(paket paket.cpp)
target_link_libraries(paket PRIVATE ${LIBNAME})
