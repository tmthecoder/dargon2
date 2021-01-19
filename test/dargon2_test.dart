// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:convert';

import 'package:dargon2/dargon2.dart';
import 'package:dargon2/src/argon2.dart';
import 'package:test/test.dart';

void main() {
  // Argon2i test group
  group('Hash Tests - Argon2i', () {
    test('v = ${0x13}, t = 2, m = 16, p = 1,', () {
      var code = hashTest(Argon2Version.V13, 2, 16, 1, 'password', 'somesalt',
          '03df1d13e10203bcc663405e31ab1687939730c9152459bca28fd10c23e38f50',
          '\$argon2i\$v=19\$m=16,t=2,p=1\$c29tZXNhbHQ\$A98dE+ECA7zGY0BeMasWh5OXMMkVJFm8oo/RDCPjj1A', Argon2Type.i);
      expect(code, DArgon2ErrorCode.ARGON2_OK);
    });
    test('v = ${0x13}, t = 2, m = 18, p = 1,', () {
      var code = hashTest(Argon2Version.V13, 2, 18, 1, 'password', 'somesalt',
          '3b1b4ad0a66b3f00b4cd04225e4e6da950ee152bf0d29aabcb123c2f1a90567a',
          '\$argon2i\$v=19\$m=18,t=2,p=1\$c29tZXNhbHQ\$OxtK0KZrPwC0zQQiXk5tqVDuFSvw0pqryxI8LxqQVno', Argon2Type.i);
      expect(code, DArgon2ErrorCode.ARGON2_OK);
    });
    test('v = ${0x13}, t = 2, m = 8, p = 1,', () {
      var code = hashTest(Argon2Version.V13, 2, 8, 1, 'password', 'somesalt',
          '48cc13c16c5a2d254a278e2c44420ba0fb2d0f070661e35d6486604a7a2ff1a9',
          '\$argon2i\$v=19\$m=8,t=2,p=1\$c29tZXNhbHQ\$SMwTwWxaLSVKJ44sREILoPstDwcGYeNdZIZgSnov8ak', Argon2Type.i);
      expect(code, DArgon2ErrorCode.ARGON2_OK);
    });
    test('v = ${0x13}, t = 2, m = 16, p = 2,', () {
      var code = hashTest(Argon2Version.V13, 2, 16, 2, 'password', 'somesalt',
          '7fbb85db7e9636115f2fd0f29ea4214baaada18b39fffed7875eeb9fa9b308c5',
          '\$argon2i\$v=19\$m=16,t=2,p=2\$c29tZXNhbHQ\$f7uF236WNhFfL9DynqQhS6qtoYs5//7Xh17rn6mzCMU', Argon2Type.i);
      expect(code, DArgon2ErrorCode.ARGON2_OK);
    });
  });
  // Argon2d test group
  group('Hash Tests - Argon2d', () {
    test('v = ${0x13}, t = 2, m = 16, p = 1,', () {
      var code = hashTest(Argon2Version.V13, 2, 16, 1, 'password', 'somesalt',
          'e742c05880c44c4df5fe79937be77897a6e41ca758affc42301f1e4040e35bd2',
          '\$argon2d\$v=19\$m=16,t=2,p=1\$c29tZXNhbHQ\$50LAWIDETE31/nmTe+d4l6bkHKdYr/xCMB8eQEDjW9I', Argon2Type.d);
      expect(code, DArgon2ErrorCode.ARGON2_OK);
    });
    test('v = ${0x13}, t = 2, m = 18, p = 1,', () {
      var code = hashTest(Argon2Version.V13, 2, 18, 1, 'password', 'somesalt',
          'd24d7d614122db6458d66b4f35dc45b1cca59f9b71945db207e78062601d2dd5',
          '\$argon2d\$v=19\$m=18,t=2,p=1\$c29tZXNhbHQ\$0k19YUEi22RY1mtPNdxFscyln5txlF2yB+eAYmAdLdU', Argon2Type.d);
      expect(code, DArgon2ErrorCode.ARGON2_OK);
    });
    test('v = ${0x13}, t = 2, m = 8, p = 1,', () {
      var code = hashTest(Argon2Version.V13, 2, 8, 1, 'password', 'somesalt',
          '7d124315b3ba588668393b2e2d6867bd9f211a4eebd240d0023e540a783a69f0',
          '\$argon2d\$v=19\$m=8,t=2,p=1\$c29tZXNhbHQ\$fRJDFbO6WIZoOTsuLWhnvZ8hGk7r0kDQAj5UCng6afA', Argon2Type.d);
      expect(code, DArgon2ErrorCode.ARGON2_OK);
    });
    test('v = ${0x13}, t = 2, m = 16, p = 2,', () {
      var code = hashTest(Argon2Version.V13, 2, 16, 2, 'password', 'somesalt',
          '59f20a66a4c31bf0438a2f494867c32120409a91380f0687aefee984ba86bda8',
          '\$argon2d\$v=19\$m=16,t=2,p=2\$c29tZXNhbHQ\$WfIKZqTDG/BDii9JSGfDISBAmpE4DwaHrv7phLqGvag', Argon2Type.d);
      expect(code, DArgon2ErrorCode.ARGON2_OK);
    });
  });
  // Argon2id test group
  group('Hash Tests - Argon2id', () {
    test('v = ${0x13}, t = 2, m = 16, p = 1,', () {
      var code = hashTest(Argon2Version.V13, 2, 16, 1, 'password', 'somesalt',
          '058202c0723cd88c24408ccac1cbf828dee63bcf3843a150ea364a1e0b4e1ff8',
          '\$argon2id\$v=19\$m=16,t=2,p=1\$c29tZXNhbHQ\$BYICwHI82IwkQIzKwcv4KN7mO884Q6FQ6jZKHgtOH/g', Argon2Type.id);
      expect(code, DArgon2ErrorCode.ARGON2_OK);
    });
    test('v = ${0x13}, t = 2, m = 18, p = 1,', () {
      var code = hashTest(Argon2Version.V13, 2, 18, 1, 'password', 'somesalt',
          '0e6408c954c4980f6313756ea01ee7ddebb362efbb20d49d08a6859787024e3f',
          '\$argon2id\$v=19\$m=18,t=2,p=1\$c29tZXNhbHQ\$DmQIyVTEmA9jE3VuoB7n3euzYu+7INSdCKaFl4cCTj8', Argon2Type.id);
      expect(code, DArgon2ErrorCode.ARGON2_OK);
    });
    test('v = ${0x13}, t = 2, m = 8, p = 1,', () {
      var code = hashTest(Argon2Version.V13, 2, 8, 1, 'password', 'somesalt',
          'fdb4ddb6d5887131b66f0b2a3740c077dd05b755845861f6b5a1dde8b1071646',
          '\$argon2id\$v=19\$m=8,t=2,p=1\$c29tZXNhbHQ\$/bTdttWIcTG2bwsqN0DAd90Ft1WEWGH2taHd6LEHFkY', Argon2Type.id);
      expect(code, DArgon2ErrorCode.ARGON2_OK);
    });
    test('v = ${0x13}, t = 2, m = 16, p = 2,', () {
      var code = hashTest(Argon2Version.V13, 2, 16, 2, 'password', 'somesalt',
          '747d7631b182faf749d7efc31aec31df4ecfe3b57c792f53800ac2c9978b4888',
          '\$argon2id\$v=19\$m=16,t=2,p=2\$c29tZXNhbHQ\$dH12MbGC+vdJ1+/DGuwx307P47V8eS9TgArCyZeLSIg', Argon2Type.id);
      expect(code, DArgon2ErrorCode.ARGON2_OK);
    });
  });
}

//Testing method to check the argon2 tester hashes
DArgon2ErrorCode hashTest(Argon2Version version, int iterations, int memory, int parallelism, String password, String salt, String hexHash, String encodedHash, Argon2Type type) {
  var s = Salt(utf8.encode(salt));
  DArgon2Result resultString;
  DArgon2Result resultBytes;
  // get hashed results
  try {
    resultString = argon2.hashPasswordStringSync(password, salt: s,
        iterations: iterations,
        memory: memory,
        parallelism: parallelism,
        version: version,
        type: type);
    resultBytes = argon2.hashPasswordBytesSync(utf8.encode(password), salt: s,
        iterations: iterations,
        memory: memory,
        parallelism: parallelism,
        version: version,
        type: type);
  } on DArgon2Exception catch (e) {
    return e.errorCode;
  }
  // Test both bytes and string for equaluty
  if (resultString.encodedString != resultBytes.encodedString) {
    return DArgon2ErrorCode.ARGON2_UNKNOWN_ERROR;
  }
  // Check if both hex strings are equivalent to the one given
  if (resultBytes.hexString != hexHash || resultString.hexString != hexHash) {
    return DArgon2ErrorCode.ARGON2_UNKNOWN_ERROR;
  }
  // Check if both are verified
  if (!argon2.verifyHashStringSync(password, encodedHash, type: type) || !argon2.verifyHashBytesSync(utf8.encode(password), utf8.encode(encodedHash), type: type)) {
    return DArgon2ErrorCode.ARGON2_UNKNOWN_ERROR;
  }
  // Check if both are verified against each other
  if (!argon2.verifyHashStringSync(password, resultBytes.encodedString, type: type) || !argon2.verifyHashStringSync(password, resultString.encodedString, type: type)) {
    return DArgon2ErrorCode.ARGON2_UNKNOWN_ERROR;
  }
  return DArgon2ErrorCode.ARGON2_OK;
}