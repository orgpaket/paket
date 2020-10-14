//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#ifndef PAKET_MACRO_ALWAYS_INLINE_HPP
#define PAKET_MACRO_ALWAYS_INLINE_HPP

#if defined(__clang__)
# if defined __has_attribute
#   if __has_attribute(always_inline)
#     define PAKET_ATTR_ALWAYS_INLINE __attribute__ ((always_inline))
#   endif
# endif
#elif defined(__GNUG__)
# if defined __has_attribute
#   if __has_attribute(always_inline)
#     define PAKET_ATTR_ALWAYS_INLINE __attribute__ ((always_inline))
#   endif
# endif
#else
# define PAKET_ATTR_ALWAYS_INLINE
#endif

#endif // PAKET_MACRO_ALWAYS_INLINE_HPP
