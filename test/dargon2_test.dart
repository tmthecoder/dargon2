import 'dart:convert';

import 'package:dargon2/dargon2.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {

    setUp(() {

    });

    test('First Test', () {
      var hash = argon2.hashPasswordBytes(utf8.encode('password'), salt: Salt(utf8.encode('somesalt')), type: Argon2Type.id, iterations: 20);
      print(hash.encodedString);
      var verify = argon2.verifyHashBytes(utf8.encode('password'), utf8.encode(hash.encodedString), type: Argon2Type.id);
      expect(verify, isTrue);
    });
  });
}
