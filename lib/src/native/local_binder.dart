/*
 * Made by Tejas Mehta
 * Made on Tuesday, October 13, 2020
 * File Name: local_binder.dart
*/

import 'dart:ffi';
import 'dart:io';

import 'package:argon2_dart/src/native/loaders/lib_loader.dart';
import 'package:argon2_dart/src/native/native_bindings.dart';

class LocalBinder {

  static LocalBinder _privateInstance;

  Argon2Hash getHash;
  Argon2Verify verifyHash;
  Argon2Encodedlen getEncodedHashLength;

  static LocalBinder get instance {
    _privateInstance ??= LocalBinder();
    return _privateInstance;
  }

  LocalBinder({String path}) {
    path ??= getPath();
    var argon2lib = LibLoader().loadLib(path);
    getHash = argon2lib
        .lookup<NativeFunction<argon2_hash>>('argon2_hash')
        .asFunction<Argon2Hash>();
    verifyHash = argon2lib
        .lookup<NativeFunction<argon2_verify>>('argon2_verify')
        .asFunction<Argon2Verify>();
    getEncodedHashLength = argon2lib
        .lookup<NativeFunction<argon2_encodedlen>>('argon2_encodedlen')
        .asFunction<Argon2Encodedlen>();
  }

  static String getPath() {
    var relativePath = './lib/src/blobs';
    if (Platform.isMacOS) return '$relativePath/libargon2-darwin.dylib';
    if (Platform.isLinux) return '$relativePath/libargon2-linux.so';
    if (Platform.isWindows) return r'lib\src\blobs\libargon2-win.dll';
    return 'libargon2-arm.so';
  }
}