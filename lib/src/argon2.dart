// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:convert';
import 'dart:ffi';
import 'package:dargon2/dargon2.dart';
import 'package:dargon2/src/native/local_binder.dart';
import 'package:ffi/ffi.dart';
import 'dart:typed_data';
import 'package:meta/meta.dart';

/// The Cannonical instance of [DArgon2].
const argon2 = DArgon2._();

/// The enum to determine the Argon2 Type used (Argon2i, Argon2d, Argon2id).
enum Argon2Type {
  /// Utilize Argon2d for hashing
  d,

  /// Utilize Argon2i for hashing
  i,

  /// Utilize Argon2id for hashing
  id
}

/// The enum used to determine the Argon2 Version used (0x10 or 0x13).
enum Argon2Version {
  /// Utilize Argon2 V10 for hashing
  V10,

  /// Utilize Argon2 V13 for hashing
  V13
}

/// A class that houses all of the methods to hash and verify a password using
/// the [Argon2] password hashing algorithm.
///
/// [Argon2]: https://github.com/P-H-C/phc-winner-argon2
///
/// This should be used via the [argon2] field.
class DArgon2 {
  /// The const constructor for the [DArgon2] class.
  const DArgon2._();

  /// The Future method to hash a [String] password with Argon2
  ///
  /// Needs a UTF-8 String [password] and a [salt] to be given with
  /// an optional parameters to control the amount of [iterations], [memory],
  /// [parallelism] used during the operation. Also optionally takes a [length]
  /// parameter for the hash's return length, as well as a [type] and [version] to
  /// pass along to the C method. This method calls the [hashPasswordStringSync]
  /// method with the given information.
  ///
  /// Returns a [Future] containing a [DArgon2Result] with the hashed password,
  /// encoded hash, and various conversion options for the hash and encoded bytes.
  Future<DArgon2Result> hashPasswordString(String password,
      {required Salt salt,
      int iterations = 32,
      int memory = 256,
      int parallelism = 2,
      int length = 32,
      Argon2Type type = Argon2Type.i,
      Argon2Version version = Argon2Version.V13}) async {
    return hashPasswordStringSync(password,
        salt: salt,
        iterations: iterations,
        memory: memory,
        parallelism: parallelism,
        length: length,
        type: type,
        version: version);
  }

  /// The Future method to hash a List<int> password with Argon2
  ///
  /// Needs a [List] of type int [password] and a [salt] to be given with
  /// an optional parameters to control the amount of [iterations], [memory],
  /// [parallelism] used during the operation. Also optionally takes a [length]
  /// parameter for the hash's return length, as well as a [type] and [version] to
  /// pass along to the C method by calling [hashPasswordBytesSync].
  ///
  /// Returns a [Future] containing a [DArgon2Result] with the hashed password,
  /// encoded hash, and various conversion options for the hash and encoded bytes.
  Future<DArgon2Result> hashPasswordBytes(List<int> password,
      {required Salt salt,
      int iterations = 32,
      int memory = 256,
      int parallelism = 2,
      int length = 32,
      Argon2Type type = Argon2Type.i,
      Argon2Version version = Argon2Version.V13}) async {
    return hashPasswordBytesSync(password,
        salt: salt,
        iterations: iterations,
        memory: memory,
        parallelism: parallelism,
        length: length,
        type: type,
        version: version);
  }

  /// The method to hash a password of type String with Argon2.
  ///
  /// Needs a UTF-8 String [password] and a [salt] to be given with
  /// an optional parameters to control the amount of [iterations], [memory],
  /// [parallelism] used during the operation. Also optionally takes a [length]
  /// parameter for the hash's return length, as well as a [type] and [version] to
  /// pass along to the C method. This method converts the string to a byte array
  /// and calls the [hashPasswordBytes] with the given byte array.
  ///
  /// Returns a [DArgon2Result] with the hashed password, encoded hash, and various
  /// conversion options for the hash and encoded bytes.
  DArgon2Result hashPasswordStringSync(String password,
      {required Salt salt,
      int iterations = 32,
      int memory = 256,
      int parallelism = 2,
      int length = 32,
      Argon2Type type = Argon2Type.i,
      Argon2Version version = Argon2Version.V13}) {
    return hashPasswordBytesSync(utf8.encode(password),
        salt: salt,
        iterations: iterations,
        memory: memory,
        parallelism: parallelism,
        length: length,
        type: type,
        version: version);
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

  /// The Future method to handle verifying a String argon2 hash against a String password
  ///
  /// Needs a UTF-8 String [password], a UTF-8 String [encodedHash], as well as an
  /// Argon2Type [type] used for the actual hash. This method gets the byte arrays of
  /// both Strings and calls [verifyHashBytes] with that info.
  ///
  /// Returns a [Future] with the [bool] of whether the hashing was a match or not
  Future<bool> verifyHashString(String password, String encodedHash,
      {Argon2Type type = Argon2Type.i}) async {
    return verifyHashStringSync(password, encodedHash, type: type);
  }

  /// The Future method to handle verifying a List<int> argon2 hash against a List<int> password
  ///
  /// Needs a [List] of type int [password], a [List] of type int [encodedHash], as well as an
  /// Argon2Type [type] used for the actual hash.
  ///
  /// Returns a [Future] with the [bool] of whether the hashing was a match or not
  Future<bool> verifyHashBytes(List<int> password, List<int> encodedHash,
      {Argon2Type type = Argon2Type.i}) async {
    return verifyHashBytesSync(password, encodedHash, type: type);
  }

  /// The method to verify a String password and a String encodedHash.
  ///
  /// Needs a UTF-8 String [password], a UTF-8 String [encodedHash], as well as an
  /// Argon2Type [type] used for the actual hash. This method gets the byte arrays of
  /// both Strings and calls [verifyHashBytes] with that info.
  ///
  /// Returns a [bool] with a true for a success and false for a failed verification.
  bool verifyHashStringSync(String password, String encodedHash,
      {Argon2Type type = Argon2Type.i}) {
    return verifyHashBytesSync(utf8.encode(password), utf8.encode(encodedHash),
        type: type);
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
}
