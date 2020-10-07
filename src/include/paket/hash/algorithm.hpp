//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#ifndef PAKET_HASH_ALGORITHM_HPP
#define PAKET_HASH_ALGORITHM_HPP

namespace paket::hash {
class algorithm {
public:
  enum class underlying_enum { sha256 = 1 };

public:
  static const algorithm sha256;

public:
  algorithm() = default;

  // NOLINTNEXTLINE(google-explicit-constructor)
  constexpr operator underlying_enum() const noexcept { return e_; }

  friend constexpr auto operator==(
    algorithm const& a, algorithm const& b) noexcept -> bool;

private:
  constexpr explicit algorithm(underlying_enum e) noexcept : e_(e) {}

private:
  underlying_enum e_{};
};

constexpr algorithm algorithm::sha256
  = algorithm(algorithm::underlying_enum::sha256);

constexpr auto operator==(algorithm const& a, algorithm const& b) noexcept
  -> bool
{
  return a.e_ == b.e_;
}

constexpr auto operator!=(algorithm const& a, algorithm const& b) noexcept
  -> bool
{
  return not(a == b);
}
} // namespace paket::hash

#endif // PAKET_HASH_ALGORITHM_HPP
