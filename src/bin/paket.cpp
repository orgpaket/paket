//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------

#include <boost/stacktrace/stacktrace.hpp>
#include <boost/stacktrace/stacktrace_fwd.hpp>
#include <cassert>
#include <cstdlib>
#include <iostream>
#include <stdexcept>
#include <string>

__attribute__((noinline)) void h();
__attribute__((noinline)) void f();
__attribute__((noinline)) void g();

__attribute__((noinline)) void h()
{
  g();
}
__attribute__((noinline)) void g()
{
  f();
}

__attribute__((noinline)) void f()
{
  std::cout << boost::stacktrace::stacktrace();
}

int main()
{
  h();
}
