//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#ifndef PAKET_COMPILER_HPP
#define PAKET_COMPILER_HPP

#include <paket/compiler_fwd.hpp>

namespace paket {
class compiler {
public:
  enum class underlying_enum { unknown = 0, gcc = 1, clang = 2 };

public:
  static const compiler unknown;
  static const compiler gcc;
  static const compiler clang;

public:
  compiler() = default;

  // NOLINTNEXTLINE(google-explicit-constructor)
  constexpr operator underlying_enum() const noexcept { return e_; }

  friend constexpr auto operator==(
    compiler const& a, compiler const& b) noexcept -> bool;

private:
  constexpr explicit compiler(underlying_enum e) noexcept : e_(e) {}

private:
  underlying_enum e_{};
};

constexpr compiler compiler::unknown
  = compiler(compiler::underlying_enum::unknown);
constexpr compiler compiler::gcc = compiler(compiler::underlying_enum::gcc);
constexpr compiler compiler::clang = compiler(compiler::underlying_enum::clang);

constexpr auto operator==(compiler const& a, compiler const& b) noexcept -> bool
{
  return a.e_ == b.e_;
}

constexpr auto operator!=(compiler const& a, compiler const& b) noexcept -> bool
{
  return not(a == b);
}
} // namespace paket

#endif // PAKET_COMPILER_HPP
