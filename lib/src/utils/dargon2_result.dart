/*
 * Made by Tejas Mehta
 * Made on Tuesday, October 13, 2020
 * File Name: dargon2_result.dart
*/

import 'dart:convert';
import 'dart:typed_data';
import 'package:convert/convert.dart';

class DArgon2Result {

  final List<int> _bytes;
  final List<int> _encodedBytes;

  DArgon2Result(this._bytes, this._encodedBytes);

  List<int> get rawBytes => _bytes;

  List<int> get encodedBytes => _encodedBytes;

  String get base64String => base64Encode(_bytes);

  String get hexString => hex.encode(_bytes);

  String get encodedString => utf8.decode(_encodedBytes);

}
