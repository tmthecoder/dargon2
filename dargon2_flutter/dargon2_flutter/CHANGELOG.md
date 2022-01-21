## 3.0.3
- Updated to align with platform interface and implementations
- Versioning mismatch changes

## 3.0.0
- **BREAKING** Library no longer supports `sync` methods
- **Potentially Breaking** When using dargon2_flutter in isolates, `DArgon2Flutter.init()` must be called before in EACH isolate before the hash/verify call
- Web Support! Instructions on setup are in the README
- Migrated to a federated plugin structure

## 2.1.0
- Migrated to use a shared dargon2_core plugin
- More modular and allows for custom Library Loader definitions
- No user-facing changes, all changes should be strictly internal

## 2.0.1
- Migrated to Null-safety
- Supports dargon2 v2.0.1

## 1.2.0
- **Potentially Breaking** The library now needs swift libs to run, so if you are making a pure Objective-C app, you'll have to create a dummy swift file and click yes when it asks to create bridging header
- Changed the underlying C library to go off the code in `Argon2Swift` so both the plugins can be used in the same application if need be

## 1.1.3
- Updated to fix the bug that disallowed release-time archiving on iOS

## 1.1.2
- Updated for concurrency with dargon2
- Contains a version bump for dargon2

## 1.1.0
- Updated for concurrency with dargon2
- Changelog contains the same underlying changes as [dargon2's Changelog](https://github.com/tmthecoder/dargon2/blob/1.1.0/CHANGELOG.md)

## 1.0.4

- Fixed formatting with dartfmt

## 1.0.3

- Changed some documentation and added a wrapper class

## 1.0.2

- Added extra documentation

## 1.0.1

- Fixed formatting and documentation errors

## 1.0.0

- Initial Release with the wrapper for iOS and Android over the main [dargon2] plugin

[dargon2]: https://github.com/tmthecoder/dargon2
