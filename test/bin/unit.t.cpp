//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#define CATCH_CONFIG_RUNNER
#include <basepaket/path_info.hpp>
#include <catch2/catch.hpp>
#include <iostream>

extern basepaket::path_info path_prefix;
basepaket::path_info path_prefix = basepaket::path_info();

auto main(int argc, char* argv[]) -> int
{
  Catch::Session session;

  namespace clara = Catch::clara;

  std::string input_prefix;
  std::string output_prefix;
  auto cli
    = session.cli()
      | clara::Opt(input_prefix, "path to input data")["--input-data"](
        "Path to Input Data ")
      | clara::Opt(output_prefix, "Path to test output ")["--output-data"](
        "Path to Test Output");

  session.cli(cli);

  int return_code = session.applyCommandLine(argc, argv);
  if (return_code != 0) {
    return return_code;
  }

  // Check if we have found the correct test data repository.
  path_prefix = basepaket::path_info(input_prefix, output_prefix);
  auto const input_filename = input_prefix + std::string("/.paket");
  auto input_file = std::ifstream(input_filename);
  std::string input_data;
  input_file >> input_data;

  if (input_data != std::string("paket")) {
    std::cout << "Test Input Directory is Invalid" << std::endl;
    return EXIT_FAILURE;
  }

  // Run all the Tests
  return session.run();
}
