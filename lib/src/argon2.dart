import 'dart:ffi';
import 'package:argon2_dart/src/hash_result.dart';
import 'package:argon2_dart/src/native/local_binder.dart';
import 'package:ffi/ffi.dart';
import 'dart:typed_data';
import 'package:meta/meta.dart';

const argon2 = Argon2._();

enum Argon2Type {
  i,
  d,
  id
}

enum Argon2Version {
  V10,
  V13
}

class Argon2 {

  const Argon2._();

  HashResult hashPassword(List<int> password, {@required List<int> salt, int iterations = 32, int memory = 1024, int parallelism = 2, int length = 32, Argon2Type type = Argon2Type.i, Argon2Version version = Argon2Version.V13}) {
    //Create pointers to pass to the C method
    var passPointer = setPtr(password);
    var saltPointer = setPtr(salt);
    var hash = setPtr(List.filled(length, 0));
    //Get the length of the encoded hash and set the encoded pointer
    var encodedLength = LocalBinder.instance.getEncodedHashLength(iterations, memory, parallelism, salt.length, length, type.index);
    var encoded = setPtr(List.filled(encodedLength, 0));
    var v = version == Argon2Version.V13 ? 0x13 : 0x10;
    LocalBinder.instance.getHash(iterations, memory, parallelism, passPointer, password.length, saltPointer, salt.length, hash, length, encoded, encodedLength, type.index, v);
    //Create new Lists of the hash and encoded values
    var hashBytes = List<int>.from(hash.asTypedList(length).cast());
    var encodedBytes = List<int>.from(encoded.asTypedList(encodedLength).cast());
    //Free all pointers
    free(hash.cast());
    free(encoded.cast());
    free(saltPointer.cast());
    free(passPointer.cast());
    return HashResult(hashBytes, encodedBytes);
  }

  bool verifyHash(List<int> password, List<int> encodedHash, {Argon2Type type = Argon2Type.i}) {
    //Create pointers to pass to the C method
    var passPointer = setPtr(password);
    var hashPointer = setPtr(encodedHash);
    //Get the result
    var result = LocalBinder.instance.verifyHash(hashPointer, passPointer, password.length, type.index);
    //Free the pointers
    free(passPointer.cast());
    free(hashPointer.cast());
    return result == 0;
  }

  Pointer<Uint8> setPtr(Iterable<int> iterable, ) {
    //Allocate a pointer in memory and set the values from the given list
    var p = allocate<Uint8>(count: Uint8List.fromList(iterable).length);
    p.asTypedList(iterable.length).setAll(0, iterable);
    return p;
  }
}
