//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#include <basepaket/path_info.hpp>
#include <catch2/catch.hpp>

extern basepaket::path_info path_prefix;

TEST_CASE("basepaket::path_info: functionality check", "[all][path_info]")
{
  REQUIRE(not path_prefix.input().empty());
  REQUIRE(not path_prefix.output().empty());

  static auto const module_prefix
    = basepaket::module_prefix("basepaket/path_info");

  auto const& [input_path, output_path]
    = basepaket::test_path(module_prefix, 1);
  REQUIRE(input_path == "input_data/basepaket/path_info/1");
  REQUIRE(output_path == "output_data/basepaket/path_info/1");
}
