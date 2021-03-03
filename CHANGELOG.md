## 2.0.1
- Updated unused imports & slight fixes

## 2.0.0
- Changed all dependencies' syntax to allow versions major above
- Added null-safety to the plugin

## 1.1.2
- Fixed version solving errors
- On that note, please DO NOT use 1.1.1

## 1.1.1
- Updated underlying dependencies to latest stable versions

## 1.1.0
- **Potentially Breaking**: Make the `hashPasswordString`, `hashPasswordBytes`, `verifyPasswordString` and `verifyPasswordBytes` methods all asynchronous
- Note: Synchronous versions are available by appending `Sync` to the method names above
- Update some documentation

## 1.0.4
- Fix the slight bug brought by having the waitFor in the generic binder instead of the conditional loader

## 1.0.3
- Fix the error that didn't load the dynamic library on mac correctly
- Resolve the dynamic library's path via a URI

## 1.0.2
- Sign the dylib for mac
- Fix formatting errors

## 1.0.1
- Update pubspec description
- Run dartfmt on the needed files

## 1.0.0

- First public release!
- Contains hashing and verification with argon2
