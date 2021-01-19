// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

/// The enum with all of the Argon2 Error codes, seen directly from the C
/// Reference Library of Argon2. The codes are sent into the Exception object as well
/// as used to retrieve the error message from the C library.
enum DArgon2ErrorCode {
  /// No error
  ARGON2_OK,

  /// Outpointer null
  ARGON2_OUTPUT_PTR_NULL,

  /// Output pointer too short
  ARGON2_OUTPUT_TOO_SHORT,

  /// Output pointer too long
  ARGON2_OUTPUT_TOO_LONG,

  /// Password too short
  ARGON2_PWD_TOO_SHORT,

  /// Password too long
  ARGON2_PWD_TOO_LONG,

  /// Salt too short
  ARGON2_SALT_TOO_SHORT,

  /// Salt too long
  ARGON2_SALT_TOO_LONG,

  /// Associated Data too short
  ARGON2_AD_TOO_SHORT,

  /// Associated Data too long
  ARGON2_AD_TOO_LONG,

  /// Secret too short
  ARGON2_SECRET_TOO_SHORT,

  /// Secret too long
  ARGON2_SECRET_TOO_LONG,

  /// Time too short
  ARGON2_TIME_TOO_SMALL,

  /// Time too long
  ARGON2_TIME_TOO_LARGE,

  /// Memory too small
  ARGON2_MEMORY_TOO_LITTLE,

  /// Memory too large
  ARGON2_MEMORY_TOO_MUCH,

  /// Too few lanes
  ARGON2_LANES_TOO_FEW,

  /// Too many lanes
  ARGON2_LANES_TOO_MANY,

  /// Null password pointer with a given nonzero length
  ARGON2_PWD_PTR_MISMATCH,

  /// Null salt pointer with a given nonzero length
  ARGON2_SALT_PTR_MISMATCH,

  /// Null secret pointer with a given nonzero length
  ARGON2_SECRET_PTR_MISMATCH,

  /// Null associated data pointer with a given nonzero length
  ARGON2_AD_PTR_MISMATCH,

  /// Memory alloc error
  ARGON2_MEMORY_ALLOCATION_ERROR,

  /// Null free memory call back
  ARGON2_FREE_MEMORY_CBK_NULL,

  /// Null allocation callback
  ARGON2_ALLOCATE_MEMORY_CBK_NULL,

  /// Context is null
  ARGON2_INCORRECT_PARAMETER,

  /// No such type of Argon2
  ARGON2_INCORRECT_TYPE,

  /// Output pointer mismatch
  ARGON2_OUT_PTR_MISMATCH,

  /// Too few threads
  ARGON2_THREADS_TOO_FEW,

  /// Too many threads
  ARGON2_THREADS_TOO_MANY,

  /// Missing arguments
  ARGON2_MISSING_ARGS,

  /// Encoding failed
  ARGON2_ENCODING_FAIL,

  /// Decoding failed
  ARGON2_DECODING_FAIL,

  /// Threading failed
  ARGON2_THREAD_FAIL,

  /// Some parameters are too short/long
  ARGON2_DECODING_LENGTH_FAIL,

  /// Verification mismatch
  ARGON2_VERIFY_MISMATCH,

  /// Unknown error
  ARGON2_UNKNOWN_ERROR
}
