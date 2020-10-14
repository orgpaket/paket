//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#ifndef PAKET_SOURCE_LOCATION_HPP
#define PAKET_SOURCE_LOCATION_HPP

#include <cstddef>
#include <string>

namespace paket {
class source_location {
public:
  source_location() = default;
  source_location(
    std::string filename,
    std::string function_name,
    std::size_t line_number,
    std::size_t column_number);

public:
  [[nodiscard]] auto filename() const noexcept -> std::string const&;
  [[nodiscard]] auto function_name() const noexcept -> std::string const&;
  [[nodiscard]] auto line_number() const noexcept -> std::size_t;
  [[nodiscard]] auto column_number() const noexcept -> std::size_t;

private:
  std::string filename_;
  std::string function_name_;
  std::size_t line_number_{};
  std::size_t column_number_{};
};
} // namespace paket

#endif // PAKET_SOURCE_LOCATION_HPP
