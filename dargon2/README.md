## dargon2
![dargon2](https://github.com/tmthecoder/dargon2/workflows/dargon2/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Dart bindings for the reference C implementation of [Argon2], the winner of the [Password Hash Competition].

This plugin is ONLY for native dart implementations. For Flutter, please use [dargon2_flutter]

[dargon2_flutter]: https://pub.dev/packages/dargon2_flutter

[Argon2]: https://github.com/P-H-C/phc-winner-argon2

[Password Hash Competition]: https://password-hashing.net

## Usage

High-level hashing and verification (for direct hashing & verification of byte arrays, check the example)

```dart
import 'package:dargon2/dargon2.dart';

void main() async {
   var password = 'password';
   //use Salt(List<int> bytes) for a salt from an Integer list
   var s = Salt.newSalt();
   //Hash with pre-set params (iterations: 32, memory: 256, parallelism: 2, 
   //length: 32, type: Argon2Type.i, version: Argon2Version.V13)
   var result = await argon2.hashPasswordString(password, salt: s);
   
   //Raw hash values available as int list, base 64 string, and hex string
   var bytesRaw = result.rawBytes;
   var base64Hash = result.base64String;
   var hexHash = result.hexString;
   
   //Encoded hash values available as int list and encoded string
   var bytesEncoded = result.encodedBytes;
   var stringEncoded = result.encodedString;
   
   //Verify password (returns true/false), uses default type (Argon2Type.i)
   var verified = await argon2.verifyHashString(password, stringEncoded);
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker].

[issue tracker]: https://github.com/tmthecoder/dargon2/issues

## Licensing

- dargon2 is Licensed under the [MIT License] 
- The C implementation of [Argon2] is licensed under a dual [Apache and CC0 License]

[MIT License]: https://github.com/tmthecoder/dargon2/blob/main/LICENSE

[Argon2]: https://github.com/P-H-C/phc-winner-argon2

[Apache and CC0 License]: https://github.com/P-H-C/phc-winner-argon2/blob/master/LICENSE
