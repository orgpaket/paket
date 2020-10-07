//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#include <catch2/catch.hpp>
#include <paket/os.hpp>
#include <testpaket/os.hpp>

TEST_CASE("paket::os: 1: template parameter", "[All]")
{
  using linux_type = testpaket::os::name<paket::os::linux>;
  constexpr auto const linux_name = linux_type();

  constexpr auto const linux_string = linux_name();
  REQUIRE(linux_string == std::string_view("linux"));

  constexpr auto const linux = paket::os(linux_type::os);
  static_assert(std::is_same_v<std::remove_cv_t<decltype(linux)>, paket::os>);
  REQUIRE(linux == paket::os::linux);
}

TEST_CASE("paket::os: 2: switch statement", "[All]")
{
  constexpr auto const linux = paket::os::linux;
  switch (linux) {
  case paket::os::linux:
    REQUIRE(true);
    break;
  case paket::os::windows:
    REQUIRE(false);
    break;
  }
}
