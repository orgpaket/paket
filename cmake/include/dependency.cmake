#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
target_link_libraries(${LIBNAME} PUBLIC Boost::boost)
target_link_libraries(${LIBNAME} PUBLIC bfg::lyra)
target_link_libraries(${LIBNAME} PUBLIC Boost::stacktrace_backtrace)
target_link_libraries(${LIBNAME} PUBLIC Boost::stacktrace_basic)
target_link_libraries(${LIBNAME} PUBLIC dl)
