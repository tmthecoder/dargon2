/*
 * Made by Tejas Mehta
 * Made on Tuesday, October 13, 2020
 * File Name: hash_result.dart
*/

import 'dart:convert';
import 'dart:typed_data';
import 'package:convert/convert.dart';

class HashResult {

  final List<int> _bytes;
  final List<int> _encodedBytes;

  HashResult(this._bytes, this._encodedBytes);

  List<int> get encryptedBytes => _bytes;

  List<int> get encodedBytes => _encodedBytes;

  String get base64String => base64Encode(_bytes);

  String get hexEncodedString => hex.encode(_bytes);

  String get encodedString => utf8.decode(_encodedBytes);

}
