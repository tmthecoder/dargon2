/*
 * Made by Tejas Mehta
 * Made on Monday, October 12, 2020
 * File Name: bindings.dart
*/

import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';

///Generic raw hash function for dart:ffi
typedef argon2_hash_raw = Int32 Function(
    Uint32 t_cost,
    Uint32 m_cost,
    Uint32 parallelism,
    Pointer<Uint8> pwd,
    IntPtr pwdlen,
    Pointer<Uint8> salt,
    IntPtr saltlen,
    Pointer<Uint8> hash,
    IntPtr hashlen,
    );

///Generic encoded hash function for dart:ffi
typedef argon2_hash_encoded = Int32 Function(
    Uint32 t_cost,
    Uint32 m_cost,
    Uint32 parallelism,
    Pointer<Uint8> pwd,
    IntPtr pwdlen,
    Pointer<Uint8> salt,
    IntPtr saltlen,
    IntPtr hashlen,
    Pointer<Uint8> encoded,
    IntPtr encodedlen
    );

///Generic hash verification function for dart:ffi
typedef argon2_verify = Int32 Function(
    Pointer<Uint8> encoded,
    Pointer<Uint8> pwd,
    IntPtr pwdlen
    );

///Generic encoded length getter function for dart:ffi
typedef argon2_encodedlen = IntPtr Function(
    Uint32 t_cost,
    Uint32 m_cost,
    Uint32 parallelism,
    Uint32 saltlen,
    Uint32 hashlen,
    Uint32 type
    );

typedef Argon2HashRaw = int Function(
    int t_cost,
    int m_cost,
    int parallelism,
    Pointer<Uint8> pwd,
    int pwdlen,
    Pointer<Uint8> salt,
    int saltlen,
    Pointer<Uint8> hash,
    int hashlen,
    );

typedef Argon2HashEncoded = int Function(
    int t_cost,
    int m_cost,
    int parallelism,
    Pointer<Uint8> pwd,
    int pwdlen,
    Pointer<Uint8> salt,
    int saltlen,
    int hashlen,
    Pointer<Uint8> encoded,
    int encodedlen
    );

typedef Argon2Verify = int Function(
    Pointer<Uint8> encoded,
    Pointer<Uint8> pwd,
    int pwdlen
    );

typedef Argon2Encodedlen = int Function(
    int t_cost,
    int m_cost,
    int parallelism,
    int saltlen,
    int hashlen,
    int type
    );

class Argon2Lib {
  Argon2Lib() {
    var path = './lib/src/blobs/libargon2-darwin.dylib';
    final dylib = DynamicLibrary.open(path);
    final rawHash = dylib
        .lookup<NativeFunction<argon2_hash_raw>>('argon2id_hash_raw')
        .asFunction<Argon2HashRaw>();
    final encodedHash = dylib
        .lookup<NativeFunction<argon2_hash_encoded>>('argon2id_hash_encoded')
        .asFunction<Argon2HashEncoded>();
    final encodedlen = dylib
        .lookup<NativeFunction<argon2_encodedlen>>('argon2_encodedlen')
        .asFunction<Argon2Encodedlen>();
    var encodedLen = encodedlen(2, 16, 1, "somesalt".length, 32, 2);
    print("test");
    var hashValue = setPtr(List.filled(32, 0));
    var password = setPtr(utf8.encode("password"));
    var salt = setPtr(utf8.encode("somesalt"));
    rawHash(2, 16, 1, password, "password".length, salt, "somesalt".length, hashValue, 32);
    var encoded = setPtr(List.filled(encodedLen, 0));
    print(encodedHash(2, 16, 1, password, "password".length, salt, "somesalt".length, 32, encoded, encodedLen));
    print(hashValue.asTypedList(32));
    print(base64Encode(hashValue.asTypedList(32)));
    print(base64Encode(hashValue.asTypedList(32)) == "BYICwHI82IwkQIzKwcv4KN7mO884Q6FQ6jZKHgtOH/g=");
    print(utf8.decode(encoded.asTypedList(encodedLen)));
    free(hashValue);
    free(password);
    free(salt);
  }

  Pointer<Uint8> setPtr(Iterable<int> iterable, ) {
    var p = allocate<Uint8>(count: Uint8List.fromList(iterable).length);
    p.asTypedList(iterable.length).setAll(0, iterable);
    return p;
  }

}