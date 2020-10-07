//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#ifndef TESTPAKET_OS_HPP
#define TESTPAKET_OS_HPP

#include <paket/os.hpp>
#include <string_view>

namespace testpaket::os {
template <typename paket::os::underlying_enum>
class name {
};

template <>
class name<paket::os::linux> {
public:
  static constexpr auto os = paket::os::linux;

  constexpr auto operator()() const noexcept -> std::string_view
  {
    return std::string_view("linux");
  }
};

} // namespace testpaket::os

#endif // TESTPAKET_OS_HPP
