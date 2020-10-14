import 'dart:convert';

import 'package:dargon2/dargon2.dart';

void main() {}

void hashString() {
  var password = 'password';
  //use Salt(List<int> bytes) for a salt from an Integer list
  var s = Salt.newSalt();
  //Hash with pre-set params (iterations: 32, memory: 1024, parallelism: 2, length: 32, type: Argon2Type.i, version: Argon2Version.V13)
  var result = argon2.hashPasswordString(password, salt: s); //type: DArgon2Result

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
  var verified = argon2.verifyHashString(password, stringEncoded); // type: bool
  print('password is verified: $verified');
}

void hashWithBytes() {
  var password = utf8.encode('password');
  //use Salt(List<int> bytes) for a salt from an Integer list
  var s = Salt.newSalt();
  //Hash with custom params
  var result = argon2.hashPasswordBytes(password,
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
  var verified = argon2.verifyHashBytes(password, bytesEncoded); // type: bool
}
