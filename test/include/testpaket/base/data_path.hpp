//------------------------------------------------------------------------------
// SPDX-License-Identifier: "GPL-2.0-only WITH GCC-exception-2.0"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#ifndef TESTPAKET_BASE_DATA_PATH_HPP
#define TESTPAKET_BASE_DATA_PATH_HPP

#include <string>

namespace testpaket::base {
struct data_path {
  data_path() = default;
  data_path(std::string input, std::string output);

  // NOLINTNEXTLINE(misc-non-private-member-variables-in-classes)
  std::string input;

  // NOLINTNEXTLINE(misc-non-private-member-variables-in-classes)
  std::string output;
};

auto test_prefix(std::string const& suffix) -> data_path;
auto test_path(std::string const& suffix) -> data_path;
} // namespace testpaket::base

#endif // TESTPAKET_BASE_DATA_PATH_HPP
