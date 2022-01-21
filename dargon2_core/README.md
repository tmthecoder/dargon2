## dargon2_core

This library generally should not be used in most contexts

This library is an umbrella library that contains all method bindings for dargon2 and dargon2_flutter's mobile components.

This library uses a given library (by dargon2 or dargon2_flutter) to create the bindings between Dart and argon2's C library. If you're using this library directly, you'll need to supply a LibLoader conforming to the class

## Usage

A simple usage example:

```dart
import 'dart:ffi';

import 'package:dargon2_core/dargon2_core.dart';

void main() {
  // Create an instance of DArgon2
  final argon2 = DArgon2(TestLibLoader());
}

class TestLibLoader implements LibLoader {
  @override
  String getPath() {
    // Return the Argon2 Reference Library's path here
    throw UnimplementedError();
  }

  @override
  DynamicLibrary loadLib() {
    // Return the actual loaded DynamicLibary here
    throw UnimplementedError();
  }
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker].

[issue tracker]: https://github.com/tmthecoder/dargon2_core/issues

## Licensing

- dargon2_core is Licensed under the [MIT License]
- The C implementation of [Argon2] is licensed under a dual [Apache and CC0 License]

[MIT License]: https://github.com/tmthecoder/dargon2_core/blob/main/LICENSE

[Argon2]: https://github.com/P-H-C/phc-winner-argon2

[Apache and CC0 License]: https://github.com/P-H-C/phc-winner-argon2/blob/master/LICENSE
