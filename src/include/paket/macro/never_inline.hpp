//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#ifndef PAKET_MACRO_NEVER_INLINE_HPP
#define PAKET_MACRO_NEVER_INLINE_HPP

#if defined(__clang__)
# if defined __has_attribute
#   if __has_attribute(noinline)
#     define PAKET_ATTR_NEVER_INLINE __attribute__ ((noinline))
#   endif
# endif
#elif defined(__GNUG__)
# if defined __has_attribute
#   if __has_attribute(noinline)
#     define PAKET_ATTR_NEVER_INLINE __attribute__ ((noinline))
#   endif
# endif
#else
# define PAKET_ATTR_NEVER_INLINE
#endif
#endif // PAKET_MACRO_NEVER_INLINE_HPP
