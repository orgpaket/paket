//------------------------------------------------------------------------------
// SPDX-License-Identifier: "GPL-2.0-only WITH GCC-exception-2.0"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#include <filesystem>
#include <fstream>
#include <testpaket/base/data_path.hpp>
#include <tuple>
#include <utility>

// NOLINTNEXTLINE(cppcoreguidelines-avoid-non-const-global-variables)
extern testpaket::base::data_path path_prefix;
// NOLINTNEXTLINE(cppcoreguidelines-avoid-non-const-global-variables)
extern testpaket::base::data_path test_path_prefix;

namespace testpaket::base {
data_path::data_path(std::string i, std::string o) : input(std::move(i)), output(std::move(o))
{
}

auto test_path(std::string const& suffix) -> data_path
{
  auto path = data_path(
    test_path_prefix.input + std::string("/") + suffix,
    test_path_prefix.output + std::string("/") + suffix);
  return path;
}

auto test_prefix(std::string const& suffix) -> data_path
{
  auto path = data_path(
    path_prefix.input + std::string("/") + suffix, path_prefix.output + std::string("/") + suffix);
  return path;
}
} // namespace testpaket::base
