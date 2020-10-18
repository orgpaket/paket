//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#ifndef PAKET_LOCKFILE_HPP
#define PAKET_LOCKFILE_HPP

#include <boost/uuid/uuid.hpp>
#include <filesystem>
#include <iterator>

namespace paket {
class lockfile {
public:
  lockfile() = default;
  explicit lockfile(std::filesystem::path filename);

  lockfile(lockfile const& lf) = delete;
  auto operator=(lockfile const& lf) -> lockfile& = delete;

  lockfile(lockfile&& lf) = default;
  auto operator=(lockfile&& lf) -> lockfile& = delete;

  ~lockfile() = default;

public:
  [[nodiscard]] auto filename() const noexcept -> std::filesystem::path const&;

private:
  std::filesystem::path filename_;
  boost::uuids::uuid uid_{};
};
} // namespace paket

#endif // PAKET_LOCKFILE_HPP
