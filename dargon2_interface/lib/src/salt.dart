// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:math';

/// A class to abstract and handle Salts for the Argon2 hashing process.
/// Allows for a user to create a salt with given bytes (List<int>)
/// or create a new salt with secure random bytes.
class Salt {
  /// Internal List of salt bytes
  final List<int> _bytes;

  /// Public Constructor accepting [_bytes] of a user's choosing.
  /// This allows a user to create their own predefined salt.
  Salt(this._bytes);

  /// Factory constructor to create a salt with random bytes.
  /// Optionally accepts a [length] of type int to create salts
  /// of a length that the user inputs.
  factory Salt.newSalt({int length = 16}) {
    return Salt(_getRandomBytes(16));
  }

  /// The method to get a List of random secure bytes with given length.
  ///
  /// Optionally accepts a [length] parameter of type int for a user-determined
  /// length of the produced list.
  ///
  /// Returns a [List] of type int with random bytes.
  static List<int> _getRandomBytes([int length = 16]) {
    final _random = Random.secure();
    return List<int>.generate(length, (i) => _random.nextInt(256));
  }

  /// A getter to get the bytes stored in the object.
  List<int> get bytes {
    return _bytes;
  }
}
