# dargon2_flutter
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A plugin to handle dart:ffi integrations for iOS and Android for argon2 password hashing in Flutter Applications.
Uses the reference C implementation of [Argon2], winner of the [Password Hash Competition] in mobile implementations while using [hash-wasm]'s WebAssembly argon2 implementation on web.

[Password Hash Competition]: https://password-hashing.net
[dargon2]: https://github.com/tmthecoder/dargon2

## Flutter version under 2.8
If you're building with a Flutter version under 2.8 (or you get an `UnimplementedError` on use), add this line into your application entrypoint (usually `main()` in `main.dart`):
```dart
void main() {
  DArgon2Flutter.init();
  runApp(MyApp());
}
```

## Pure Objective-C iOS
If you're using Objective-C for the iOS portion of your application (created with Objective-C and no Swift code), there's a few extra steps:
- Open the Xcode workspace (type in `open iOS/Runner.xcworkspace` in the terminal in the project's root directory)
- Right click the `Runner` directory (Folder, not project/workspace)
- Click `New File`
- Select `Swift File` in the prompt
- (**This is the Important Step**) Select `Create Bridging Header` when the prompt comes up
- You don't have to add anything to that swift file or the bridging header, but it needs to be there along with the bridging header in order for the plugin to compile correctly for iOS

## Usage

High-level hashing and verification (for direct hashing & verification of byte arrays, check the example on [dargon2])

```dart
void _hash() async {
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

## Special Usage - Isolates/Compute

When using dargon2_flutter within Dart Isolates, an additional step must be taken or an `UnimplementedError` will be thrown.

The method that will be called in the Isolate must call `DArgon2Flutter.init()`

It should follow this example (with the full program in the example folder):

```dart
Future<void> hashWithArgon2Isolate(Map map) async {
  DArgon2Flutter.init();
  DArgon2Result result =
      await argon2.hashPasswordString(map["hashString"]!, salt: Salt.newSalt());
  print("Hex String: ${result.hexString}");
  print("Base64 String: ${result.base64String}");
  print("Encoded String: ${result.encodedString}");
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker].

[issue tracker]: https://github.com/tmthecoder/dargon2_flutter/issues

## Licensing

- dargon2_flutter and all platform implementations are Licensed under the [MIT License]
- dargon2_core is Licensed under the [MIT License](https://github.com/tmthecoder/dargon2_core/blob/main/LICENSE)
- The C implementation of [Argon2] is licensed under a dual [Apache and CC0 License]
- [hash-wasm] is licensed under the [MIT License](https://github.com/Daninet/hash-wasm/blob/master/LICENSE)

[MIT License]: https://github.com/tmthecoder/dargon2_flutter/blob/main/LICENSE

[Argon2]: https://github.com/P-H-C/phc-winner-argon2

[hash-wasm]: https://github.com/Daninet/hash-wasm

[Apache and CC0 License]: https://github.com/P-H-C/phc-winner-argon2/blob/master/LICENSE
