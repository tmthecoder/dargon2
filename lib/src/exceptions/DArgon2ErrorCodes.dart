// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

/// The enum with all of the Argon2 Error codes, seen directly from the C
/// Reference Library of Argon2. The codes are sent into the Exception object as well
/// as used to retrieve the error message from the C library.
enum DArgon2ErrorCode {
  ARGON2_OK, // No error

  ARGON2_OUTPUT_PTR_NULL, // Outpointer null

  ARGON2_OUTPUT_TOO_SHORT, // Output pointer too short
  ARGON2_OUTPUT_TOO_LONG, // Output pointer too long

  ARGON2_PWD_TOO_SHORT, // Password too short
  ARGON2_PWD_TOO_LONG, // Password too long

  ARGON2_SALT_TOO_SHORT, // Salt too short
  ARGON2_SALT_TOO_LONG, // Salt too long

  ARGON2_AD_TOO_SHORT, // Associated Data too short
  ARGON2_AD_TOO_LONG, // Associated Data too long

  ARGON2_SECRET_TOO_SHORT, // Secret too short
  ARGON2_SECRET_TOO_LONG, // Secret too long

  ARGON2_TIME_TOO_SMALL, // Time too short
  ARGON2_TIME_TOO_LARGE, // Time too long

  ARGON2_MEMORY_TOO_LITTLE, // Memory too small
  ARGON2_MEMORY_TOO_MUCH, // Memory too large

  ARGON2_LANES_TOO_FEW, // Too few lanes
  ARGON2_LANES_TOO_MANY, // Too many lanes

  ARGON2_PWD_PTR_MISMATCH, // Null password pointer with a given nonzero length
  ARGON2_SALT_PTR_MISMATCH, // Null salt pointer with a given nonzero length
  ARGON2_SECRET_PTR_MISMATCH, // Null secret pointer with a given nonzero length
  ARGON2_AD_PTR_MISMATCH, // Null associated data pointer with a given nonzero length

  ARGON2_MEMORY_ALLOCATION_ERROR, // Memory alloc error

  ARGON2_FREE_MEMORY_CBK_NULL, // Null free memory call back
  ARGON2_ALLOCATE_MEMORY_CBK_NULL, // Null allocation callback

  ARGON2_INCORRECT_PARAMETER, // Context is null
  ARGON2_INCORRECT_TYPE, // No such type of Argon2

  ARGON2_OUT_PTR_MISMATCH, // Output pointer mismatch

  ARGON2_THREADS_TOO_FEW, // Too few threads
  ARGON2_THREADS_TOO_MANY, // Too many threads

  ARGON2_MISSING_ARGS, // Missing arguments

  ARGON2_ENCODING_FAIL, // Encoding failed

  ARGON2_DECODING_FAIL, // Decoding failed

  ARGON2_THREAD_FAIL, // Threading failed

  ARGON2_DECODING_LENGTH_FAIL, // Some parameters are too short/long

  ARGON2_VERIFY_MISMATCH, //Verification mismatch

  ARGON2_UNKNOWN_ERROR // Unknown error
}
