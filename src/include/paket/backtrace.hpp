//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#ifndef PAKET_BACKTRACE_HPP
#define PAKET_BACKTRACE_HPP

#include <cstddef>
#include <paket/macro/always_inline.hpp>
#include <paket/source_location.hpp>
#include <vector>

namespace paket {
class backtrace {
public:
  PAKET_ATTR_ALWAYS_INLINE
  static auto current() -> backtrace;

public:
  [[nodiscard]] auto size() const noexcept -> std::size_t;

  [[nodiscard]] auto operator[](std::size_t index) const
    -> source_location const&;

private:
  std::vector<source_location> source_location_array_;
};
} // namespace paket

#endif // PAKET_BACKTRACE_HPP
