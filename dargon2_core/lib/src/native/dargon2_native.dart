/// Made by Tejas Mehta
/// Made on Thursday, December 09, 2021
/// File Name: dargon2_native.dart

import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:dargon2_interface/dargon2_interface.dart';
import 'package:ffi/ffi.dart';

import 'loaders/lib_loader.dart';
import 'local_binder.dart';

class DArgon2Native extends DArgon2 {
  DArgon2Native(LibLoader loader) {
    LocalBinder.initialize(loader);
  }

  /// The method to hash a byte array of type List<int> with Argon2.
  ///
  /// Needs a [List] of type int [password] and a [salt] to be given with
  /// an optional parameters to control the amount of [iterations], [memory],
  /// [parallelism] used during the operation. Also optionally takes a [length]
  /// parameter for the hash's return length, as well as a [type] and [version] to
  /// pass along to the C method.
  ///
  /// Returns a [DArgon2Result] with the hashed password, encoded hash, and various
  /// conversion options for the hash and encoded bytes.
  DArgon2Result hashPasswordBytesSync(List<int> password,
      {required Salt salt,
      int iterations = 32,
      int memory = 256,
      int parallelism = 2,
      int length = 32,
      Argon2Type type = Argon2Type.i,
      Argon2Version version = Argon2Version.V13}) {
    //Create pointers to pass to the C method
    var passPointer = _setPtr(password);
    var saltPointer = _setPtr(salt.bytes);
    var hash = _setPtr(List.filled(length, 0));
    //Get the length of the encoded hash and set the encoded pointer
    var encodedLength = LocalBinder.instance.getEncodedHashLength(
        iterations, memory, parallelism, salt.bytes.length, length, type.index);
    var encoded = _setPtr(List.filled(encodedLength, 0));
    var v = version == Argon2Version.V13 ? 0x13 : 0x10;
    var result = LocalBinder.instance.getHash(
        iterations,
        memory,
        parallelism,
        passPointer,
        password.length,
        saltPointer,
        salt.bytes.length,
        hash,
        length,
        encoded,
        encodedLength,
        type.index,
        v);
    //Create new Lists of the hash and encoded values
    var hashBytes = List<int>.from(hash.asTypedList(length).cast());
    var encodedBytes =
        List<int>.from(encoded.asTypedList(encodedLength).cast());
    if (encodedBytes.last == 0) {
      encodedBytes.removeLast();
    }
    //Free all pointers
    malloc.free(hash);
    malloc.free(encoded);
    malloc.free(saltPointer);
    malloc.free(passPointer);
    if (DArgon2ErrorCode.values[result.abs()] != DArgon2ErrorCode.ARGON2_OK) {
      throw DArgon2Exception(
          LocalBinder.instance.getErrorMessage(result).toDartString(),
          DArgon2ErrorCode.values[result.abs()]);
    }
    return DArgon2Result(hashBytes, encodedBytes);
  }

  /// The method to verify a List<int> password and a List<int> encodedHash.
  ///
  /// Needs a [List] of type int [password], a [List] of type int [encodedHash], as well as an
  /// Argon2Type [type] used for the actual hash.
  ///
  /// Returns a [bool] with a true for a success and false for a failed verification.
  bool verifyHashBytesSync(List<int> password, List<int> encodedHash,
      {Argon2Type type = Argon2Type.i}) {
    //Create pointers to pass to the C method
    var passPointer = _setPtr(password);
    var hashPointer = utf8.decode(encodedHash).toNativeUtf8();
    // var hashPointer = _setPtr(encodedHash);
    //Get the result
    var result = LocalBinder.instance
        .verifyHash(hashPointer, passPointer, password.length, type.index);
    //Free the pointers
    malloc.free(passPointer);
    malloc.free(hashPointer);
    if (DArgon2ErrorCode.values[result.abs()] != DArgon2ErrorCode.ARGON2_OK) {
      throw DArgon2Exception(
          LocalBinder.instance.getErrorMessage(result).toDartString(),
          DArgon2ErrorCode.values[result.abs()]);
    }
    return result == 0;
  }

  /// The method used internally to allocate memory for the sent pointers
  /// via the Foreign Function Interface (dart:ffi) for Argon2 Computations.
  ///
  /// Needs an [Iterable] of type int to be given in order to allocate the memory
  /// using the length of the list, and setting each value of the iterable
  /// in the pointer's memory.
  ///
  /// Returns a [Pointer] of type [Uint8] to be used for Argon2 computations.
  Pointer<Uint8> _setPtr(Iterable<int> iterable) {
    //Allocate a pointer in memory and set the values from the given list
    var p = malloc<Uint8>(Uint8List.fromList(iterable.toList()).length);
    p.asTypedList(iterable.length).setAll(0, iterable);
    return p;
  }

  @override
  Future<DArgon2Result> hashPasswordBytes(List<int> password,
          {required Salt salt,
          int iterations = 32,
          int memory = 256,
          int parallelism = 2,
          int length = 32,
          Argon2Type type = Argon2Type.i,
          Argon2Version version = Argon2Version.V13}) async =>
      hashPasswordBytesSync(password,
          salt: salt,
          iterations: iterations,
          memory: memory,
          parallelism: parallelism,
          length: length,
          type: type,
          version: version);

  @override
  Future<bool> verifyHashBytes(List<int> password, List<int> encodedHash,
          {Argon2Type type = Argon2Type.i}) async =>
      verifyHashBytesSync(password, encodedHash, type: type);
}
