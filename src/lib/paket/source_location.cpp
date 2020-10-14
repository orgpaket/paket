//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------

#include <paket/source_location.hpp>
#include <utility>

namespace paket {
source_location::source_location(
  std::string filename,
  std::string function_name,
  std::size_t line_number,
  std::size_t column_number)
: filename_(std::move(filename)),
  function_name_(std::move(function_name)),
  line_number_(line_number),
  column_number_(column_number)
{
}

auto source_location::filename() const noexcept -> std::string const&
{
  return filename_;
}

auto source_location::function_name() const noexcept -> std::string const&
{
  return function_name_;
}

auto source_location::line_number() const noexcept -> std::size_t
{
  return line_number_;
}

auto source_location::column_number() const noexcept -> std::size_t
{
  return column_number_;
}
} // namespace paket
