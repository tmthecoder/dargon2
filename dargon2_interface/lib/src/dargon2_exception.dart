// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dargon2_error_codes.dart';

/// A generic exception class to present each of the thrown exceptions from
/// the Argon2 Library to allow users to know exactly what errored
///
/// ```dart
/// try {
///   argon2.verifyHashString('password', 'incorrect encoded hash');
/// } on DArgon2Exception catch (e) {
///   print(e.message);
/// }
/// ```
class DArgon2Exception implements Exception {
  /// The constructor for the Exception, which simplifies a thrown error in the Argon2
  /// hashing or verification process.
  ///
  /// Requires a String [message] describing the error and a DArgon2Exception [errorCode]
  /// for a brief error description
  DArgon2Exception(this.message, this.errorCode);

  /// The verbose error message, describing what caused the error.
  ///
  /// The message is retrieved from the C Argon2 Library, directly correlating
  /// with the errors in the library
  final String message;

  /// The enumerated error code type, giving a brief error description.
  ///
  /// The type is directly related to the error types in the C Argon2 Library,
  /// and the use of an enum allows users to compare the errors easily
  final DArgon2ErrorCode errorCode;

  /// The toString method that returns a String containing both the [errorCode]
  /// and the [message]
  @override
  String toString() {
    return '[$errorCode] $message';
  }
}
