//------------------------------------------------------------------------------
// SPDX-License-Identifier: "GPL-2.0-only WITH GCC-exception-2.0"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#include <filesystem>
#include <fstream>
#include <iostream>
#include <testpaket/base/catch.hpp>

PAKET_CATCH_MAIN(meta)

TEST_CASE("testpaket::meta::0: verify input", "[all]")
{
  auto const& [input_path, output_path] = testpaket::base::test_path("0");
  auto const input_filename = input_path + "/version";
  std::cout << input_filename;
  REQUIRE(std::filesystem::exists(input_filename));
  auto input_file = std::ifstream(input_filename);
  std::string input_data;
  input_file >> input_data;
  REQUIRE(input_data == std::string("1"));
}
