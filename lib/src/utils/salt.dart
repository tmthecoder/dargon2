/*
 * Made by Tejas Mehta
 * Made on Tuesday, October 13, 2020
 * File Name: salt.dart
*/

import 'package:dargon2/src/utils/secure_random_gen.dart';

class Salt {
  final List<int> _bytes;

  Salt(this._bytes);

  factory Salt.newSalt({int length = 16}) {
    return Salt(SecureRandomGen.getRandomBytes(16));
  }

  List<int> get bytes {
    return _bytes;
  }
}
