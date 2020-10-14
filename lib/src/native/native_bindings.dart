/*
 * Made by Tejas Mehta
 * Made on Monday, October 12, 2020
 * File Name: native_bindings.dart
*/

import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:argon2_dart/src/native/loaders/lib_loader.dart';
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

///Generic argon2 hash function for dart:ffi
typedef argon2_hash = Int32 Function(
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

///Generic hash verification function for dart:ffi
typedef argon2_verify = Int32 Function(
    Pointer<Uint8> encoded,
    Pointer<Uint8> pwd,
    IntPtr pwdlen,
    Uint32 type,
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

typedef Argon2Hash = int Function(
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

typedef Argon2Verify = int Function(
    Pointer<Uint8> encoded,
    Pointer<Uint8> pwd,
    int pwdlen,
    int type
    );

typedef Argon2Encodedlen = int Function(
    int t_cost,
    int m_cost,
    int parallelism,
    int saltlen,
    int hashlen,
    int type
    );