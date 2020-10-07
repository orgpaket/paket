//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#ifndef PAKET_OS_HPP
#define PAKET_OS_HPP

namespace paket {
class os {
public:
  enum class underlying_enum { linux = 1, windows = 2 };

public:
  static const os linux;
  static const os windows;

public:
  os() = default;

  // NOLINTNEXTLINE(google-explicit-constructor)
  constexpr operator underlying_enum() const noexcept { return e_; }

  friend constexpr auto operator==(os const& a, os const& b) noexcept -> bool;

private:
  constexpr explicit os(underlying_enum e) noexcept : e_(e) {}

private:
  underlying_enum e_{};
};

constexpr os os::linux = os(os::underlying_enum::linux);
constexpr os os::windows = os(os::underlying_enum::windows);

constexpr auto operator==(os const& a, os const& b) noexcept -> bool
{
  return a.e_ == b.e_;
}

constexpr auto operator!=(os const& a, os const& b) noexcept -> bool
{
  return not(a == b);
}
} // namespace paket

#endif // PAKET_OS_HPP
