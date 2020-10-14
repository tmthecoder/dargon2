/*
 * Made by Tejas Mehta
 * Made on Tuesday, October 13, 2020
 * File Name: local_binder.dart
*/

import 'dart:ffi';
import 'dart:io';

import 'package:dargon2/src/native/loaders/lib_loader.dart';

///Generic argon2 hash function for dart:ffi
typedef _argon2_hash = Int32 Function(
    Uint32 t_cost,
    Uint32 m_cost,
    Uint32 parallelism,
    Pointer<Uint8> pwd,
    IntPtr pwdlen,
    Pointer<Uint8> salt,
    IntPtr saltlen,
    Pointer<Uint8> hash,
    IntPtr hashlen,
    Pointer<Uint8> encoded,
    IntPtr encodedlen,
    Uint32 type,
    Uint32 version,
    );

typedef _Argon2Hash = int Function(
    int t_cost,
    int m_cost,
    int parallelism,
    Pointer<Uint8> pwd,
    int pwdlen,
    Pointer<Uint8> salt,
    int saltlen,
    Pointer<Uint8> hash,
    int hashlen,
    Pointer<Uint8> encoded,
    int encodedlen,
    int type,
    int version,
    );

///Generic hash verification function for dart:ffi
typedef _argon2_verify = Int32 Function(
    Pointer<Uint8> encoded,
    Pointer<Uint8> pwd,
    IntPtr pwdlen,
    Uint32 type,
    );

typedef _Argon2Verify = int Function(
    Pointer<Uint8> encoded,
    Pointer<Uint8> pwd,
    int pwdlen,
    int type
    );

///Generic encoded length getter function for dart:ffi
typedef _argon2_encodedlen = IntPtr Function(
    Uint32 t_cost,
    Uint32 m_cost,
    Uint32 parallelism,
    Uint32 saltlen,
    Uint32 hashlen,
    Uint32 type
    );

typedef _Argon2Encodedlen = int Function(
    int t_cost,
    int m_cost,
    int parallelism,
    int saltlen,
    int hashlen,
    int type
    );

class LocalBinder {

  static LocalBinder _privateInstance;

  _Argon2Hash getHash;
  _Argon2Verify verifyHash;
  _Argon2Encodedlen getEncodedHashLength;

  static LocalBinder get instance {
    _privateInstance ??= LocalBinder();
    return _privateInstance;
  }

  LocalBinder({String path}) {
    path ??= getPath();
    var argon2lib = LibLoader().loadLib(path);
    getHash = argon2lib
        .lookup<NativeFunction<_argon2_hash>>('argon2_hash')
        .asFunction<_Argon2Hash>();
    verifyHash = argon2lib
        .lookup<NativeFunction<_argon2_verify>>('argon2_verify')
        .asFunction<_Argon2Verify>();
    getEncodedHashLength = argon2lib
        .lookup<NativeFunction<_argon2_encodedlen>>('argon2_encodedlen')
        .asFunction<_Argon2Encodedlen>();
  }

  static String getPath() {
    var relativePath = './lib/src/blobs';
    if (Platform.isMacOS) return '$relativePath/libargon2-darwin.dylib';
    if (Platform.isLinux) return '$relativePath/libargon2-linux.so';
    if (Platform.isWindows) return r'lib\src\blobs\libargon2-win.dll';
    return 'libargon2-arm.so';
  }
}