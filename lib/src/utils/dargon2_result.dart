// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:convert';
import 'package:convert/convert.dart';

/// A class that stores the results from an Argon2 Hashing operation.
/// Allows for a user to get various values from the List<int> [_bytes] and [_encodedBytes].
class DArgon2Result {
  /// Private fields to store the raw bytes and encoded bytes from the hash operation.
  final List<int> _bytes;
  final List<int> _encodedBytes;

  /// Public Constructor to create a [DArgon2Result] object from the given raw bytes.
  /// and encoded bytes.
  DArgon2Result(this._bytes, this._encodedBytes);

  /// A getter to return the raw bytes as a [List] of type int from the
  /// given raw bytes ([_bytes]).
  List<int> get rawBytes => _bytes;

  /// A getter to return the encoded bytes as a [List] of type int from the
  /// given encoded bytes ([_encodedBytes])
  List<int> get encodedBytes => _encodedBytes;

  /// A getter to return a base64 String from the raw bytes ([_bytes]).
  String get base64String => base64Encode(_bytes);

  /// A getter to return a hex String from the raw bytes ([_bytes])
  String get hexString => hex.encode(_bytes);

  /// A getter to return a UTF-8 String from the encoded bytes ([_encodedBytes])
  String get encodedString => utf8.decode(_encodedBytes);
}
