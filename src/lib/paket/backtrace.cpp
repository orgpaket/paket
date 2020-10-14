//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------

#include <execinfo.h>
#include <elfutils/libdwfl.h>
#include <paket/backtrace.hpp>

namespace paket {
auto backtrace::size() const noexcept -> std::size_t
{
  return std::size(source_location_array_);
}

auto backtrace::operator[](std::size_t index) const -> source_location const&
{
  return source_location_array_[index];
}

auto backtrace::current() -> backtrace
{
  backtrace bt;
  // NOLINTNEXTLINE(cppcoreguidelines-avoid-c-arrays)
  void* stack[512];
  int stack_size = ::backtrace(stack, sizeof stack / sizeof *stack);

  return bt;
}
} // namespace paket
