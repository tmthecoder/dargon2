// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:convert';

import 'package:dargon2/dargon2.dart';

void main() {
  hashString();
  hashWithBytes();
}

void hashString() async {
  var password = 'password';
  //use Salt(List<int> bytes) for a salt from an Integer list
  var s = Salt.newSalt();
  //Hash with pre-set params (iterations: 32, memory: 256, parallelism: 2, length: 32, type: Argon2Type.i, version: Argon2Version.V13)
  var result = await argon2.hashPasswordString(password, salt: s); //type: DArgon2Result

  //Raw hash values available as int list, base 64 string, and hex string
  var bytesRaw = result.rawBytes; // type: List<int>
  print('Raw Byte Array: $bytesRaw');
  var base64Hash = result.base64String; // type: String
  print('Base64 Hash: $base64Hash');
  var hexHash = result.hexString; // type: String
  print('Hex Hash: $hexHash');

  //Encoded hash values available as int list and encoded string
  var bytesEncoded = result.encodedBytes; // type: List<int>
  print('Raw Encoded Bytes Array: $bytesEncoded');
  var stringEncoded = result.encodedString; // type: String
  print('Encoded UTF-8 String: $stringEncoded');

  //Verify password (returns true/false), uses default type (Argon2Type.i)
  var verified = await argon2.verifyHashString(password, stringEncoded); // type: bool
  print('password is verified: $verified');
}

void hashWithBytes() async {
  var password = utf8.encode('password');
  //use Salt(List<int> bytes) for a salt from an Integer list
  var s = Salt.newSalt();
  //Hash with custom params
  var result = await argon2.hashPasswordBytes(password,
      salt: s,
      iterations: 20,
      memory: 512,
      parallelism: 4,
      length: 16,
      type: Argon2Type.id,
      version: Argon2Version.V13); //type: DArgon2Result

  //Raw hash values available as int list, base 64 string, and hex string
  var bytesRaw = result.rawBytes; // type: List<int>
  print('Raw Byte Array: $bytesRaw');
  var base64Hash = result.base64String; // type: String
  print('Base64 Hash: $base64Hash');
  var hexHash = result.hexString; // type: String
  print('Hex Hash: $hexHash');

  //Encoded hash values available as int list and encoded string
  var bytesEncoded = result.encodedBytes; // type: List<int>
  print('Raw Encoded Bytes Array: $bytesEncoded');
  var stringEncoded = result.encodedString; // type: String
  print('Encoded UTF-8 String: $stringEncoded');

  //Verify password (returns true/false)
  var verified = await argon2.verifyHashBytes(password, bytesEncoded, type: Argon2Type.id); // type: bool
  print('password is verified: $verified');
}
