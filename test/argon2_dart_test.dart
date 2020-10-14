import 'dart:convert';

import 'package:argon2_dart/argon2_dart.dart';
import 'package:argon2_dart/src/hash_result.dart';
import 'package:argon2_dart/src/native/native_bindings.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {

    setUp(() {

    });

    test('First Test', () {
      var hash = argon2.hashPassword(utf8.encode('password'), salt: utf8.encode('somesalt'), type: Argon2Type.id, iterations: 20);
      print(hash.encodedString);
      var veriy = argon2.verifyHash(utf8.encode('password'), utf8.encode(hash.encodedString), type: Argon2Type.id);
      expect(veriy, isTrue);
    });
  });
}
