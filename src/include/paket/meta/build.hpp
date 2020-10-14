//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#ifndef PAKET_META_BUILD_HPP
#define PAKET_META_BUILD_HPP

#include <paket/compiler.hpp>
#include <paket/meta/detail/compiler.hpp>

namespace paket::meta {
class build {
public:
  [[nodiscard]] constexpr auto compiler() const noexcept -> compiler
  {
    return compiler_;
  }

private:
  class compiler compiler_ {
    detail::detect_compiler()
  };
};
} // namespace paket::meta

#endif // PAKET_META_BUILD_HPP
