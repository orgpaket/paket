//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#ifndef PAKET_META_DETAIL_COMPILER_HPP
#define PAKET_META_DETAIL_COMPILER_HPP

#include <paket/compiler.hpp>

namespace paket::meta::detail {
constexpr auto detect_compiler() noexcept -> compiler
{
#if defined(__GNUG__)
  return compiler::gcc;
#elif defined(__clang__)
  return compiler::clang
#else
  return compiler::unknown
#endif
}
} // namespace paket::meta::detail

#endif // PAKET_META_DETAIL_COMPILER_HPP
