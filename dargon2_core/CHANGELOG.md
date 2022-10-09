## 2.1.1
- Bump `ffi` version to `2.0.0`

## 2.1.0
- Fix repository & homepage links to point to newly structured repo
- Match versioning for dargon2_flutter's desktop support addition

## 2.0.2
- Bump Dart version down to 2.14 so dargon2_flutter can use this w/ Flutter 2.5

## 2.0.1
- Slight bug fix on a verification that missed the type 

## 2.0.0
- BREAKING: All `sync` ending methods have been removed. Please use the asynchronous methods
- All interface code has moved to the `dargon2_interface` plugin

## 1.0.0

- Initial version.
- Moved all bindings (function mappings from C to Dart) here instead of dargon2
- dargon2 and dargon2_flutter both share inheritance off this plugin and handle library loading in their respective plugins
