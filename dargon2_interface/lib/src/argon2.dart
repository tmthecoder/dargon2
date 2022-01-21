// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:convert';
import 'dargon2_result.dart';

import 'salt.dart';

/// The enum to determine the Argon2 Type used (Argon2i, Argon2d, Argon2id).
enum Argon2Type {
  /// Utilize Argon2d for hashing
  d,

  /// Utilize Argon2i for hashing
  i,

  /// Utilize Argon2id for hashing
  id
}

/// The enum used to determine the Argon2 Version used (0x10 or 0x13).
enum Argon2Version {
  /// Utilize Argon2 V10 for hashing
  V10,

  /// Utilize Argon2 V13 for hashing
  V13
}

/// A class that houses all of the methods to hash and verify a password using
/// the [Argon2] password hashing algorithm.
///
/// [Argon2]: https://github.com/P-H-C/phc-winner-argon2
///
/// This should be used via the [argon2] field.
abstract class DArgon2 {
  /// The Future method to hash a [String] password with Argon2
  ///
  /// Needs a UTF-8 String [password] and a [salt] to be given with
  /// an optional parameters to control the amount of [iterations], [memory],
  /// [parallelism] used during the operation. Also optionally takes a [length]
  /// parameter for the hash's return length, as well as a [type] and [version].
  ///
  /// Returns a [Future] containing a [DArgon2Result] with the hashed password,
  /// encoded hash, and various conversion options for the hash and encoded bytes.
  Future<DArgon2Result> hashPasswordString(String password,
          {required Salt salt,
          int iterations = 32,
          int memory = 256,
          int parallelism = 2,
          int length = 32,
          Argon2Type type = Argon2Type.i,
          Argon2Version version = Argon2Version.V13}) =>
      hashPasswordBytes(utf8.encode(password),
          salt: salt,
          iterations: iterations,
          memory: memory,
          parallelism: parallelism,
          length: length,
          type: type,
          version: version);

  /// The Future method to hash a List<int> password with Argon2
  ///
  /// Needs a [List] of type int [password] and a [salt] to be given with
  /// an optional parameters to control the amount of [iterations], [memory],
  /// [parallelism] used during the operation. Also optionally takes a [length]
  /// parameter for the hash's return length, as well as a [type] and [version].
  ///
  /// Returns a [Future] containing a [DArgon2Result] with the hashed password,
  /// encoded hash, and various conversion options for the hash and encoded bytes.
  Future<DArgon2Result> hashPasswordBytes(List<int> password,
      {required Salt salt,
      int iterations = 32,
      int memory = 256,
      int parallelism = 2,
      int length = 32,
      Argon2Type type = Argon2Type.i,
      Argon2Version version = Argon2Version.V13});

  /// The Future method to handle verifying a String argon2 hash against a String password
  ///
  /// Needs a UTF-8 String [password], a UTF-8 String [encodedHash], as well as an
  /// Argon2Type [type] used for the actual hash. This method gets the byte arrays of
  /// both Strings and calls [verifyHashBytes] with that info.
  ///
  /// Returns a [Future] with the [bool] of whether the hashing was a match or not
  Future<bool> verifyHashString(String password, String encodedHash,
          {Argon2Type type = Argon2Type.i}) =>
      verifyHashBytes(utf8.encode(password), utf8.encode(encodedHash),
          type: type);

  /// The Future method to handle verifying a List<int> argon2 hash against a List<int> password
  ///
  /// Needs a [List] of type int [password], a [List] of type int [encodedHash], as well as an
  /// Argon2Type [type] used for the actual hash.
  ///
  /// Returns a [Future] with the [bool] of whether the hashing was a match or not
  Future<bool> verifyHashBytes(List<int> password, List<int> encodedHash,
      {Argon2Type type = Argon2Type.i});
}
