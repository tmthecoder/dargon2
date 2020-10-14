/*
 * Made by Tejas Mehta
 * Made on Tuesday, October 13, 2020
 * File Name: secure_random_gen.dart
*/

import 'dart:math';

class SecureRandomGen {
  static List<int> getRandomBytes([int length = 16]) {
    final _random = Random.secure();
    return List<int>.generate(length, (i) => _random.nextInt(256));
  }
}
