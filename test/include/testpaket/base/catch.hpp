//------------------------------------------------------------------------------
// SPDX-License-Identifier: "GPL-2.0-only WITH GCC-exception-2.0"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#ifndef TESTPAKET_BASE_CATCH_HPP
#define TESTPAKET_BASE_CATCH_HPP

#include <catch2/catch_session.hpp>
#include <catch2/catch_test_macros.hpp>
#include <testpaket/base/data_path.hpp>

// NOLINTNEXTLINE(cppcoreguidelines-macro-usage)
#define PAKET_CATCH_MAIN(relative_data_path)                                                     \
                                                                                                   \
  using testpaket::base::data_path;                                                              \
                                                                                                   \
  extern data_path path_prefix; /* NOLINT(cppcoreguidelines-avoid-non-const-global-variables)*/    \
                                                                                                   \
  /* NOLINTNEXTLINE(cppcoreguidelines-avoid-non-const-global-variables)*/                          \
  data_path path_prefix = data_path();                                                             \
                                                                                                   \
  extern data_path                                                                                 \
    test_path_prefix; /* NOLINT(cppcoreguidelines-avoid-non-const-global-variables)*/              \
                                                                                                   \
  /* NOLINTNEXTLINE(cppcoreguidelines-avoid-non-const-global-variables)*/                          \
  data_path test_path_prefix = data_path();                                                        \
                                                                                                   \
  auto main(int argc, char* argv[])->int                                                           \
  {                                                                                                \
    Catch::Session session;                                                                        \
                                                                                                   \
    namespace clara = Catch::Clara;                                                                \
                                                                                                   \
    std::string input;                                                                             \
    std::string output;                                                                            \
    auto cli = session.cli() | clara::Opt(input, "Path to Input")["--input-data"]("Path to Input") \
               | clara::Opt(output, "Path for Output")["--output-data"]("Path for Output");        \
                                                                                                   \
    session.cli(cli);                                                                              \
                                                                                                   \
    int return_code = session.applyCommandLine(argc, argv);                                        \
    if (return_code != 0) {                                                                        \
      return return_code;                                                                          \
    }                                                                                              \
    path_prefix = data_path(input, output);                                                        \
    test_path_prefix                                                                               \
      = testpaket::base::test_prefix(std::string("unit/") + std::string(#relative_data_path));   \
                                                                                                   \
    return session.run();                                                                          \
  }

#define PAKET_VERIFY_INPUT

#endif // TESTPAKET_BASE_CATCH_HPP
