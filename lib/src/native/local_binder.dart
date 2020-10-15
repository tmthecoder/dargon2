// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:ffi';
import 'dart:io';

import 'package:dargon2/src/native/loaders/lib_loader.dart';
import 'package:ffi/ffi.dart';

/// A function definition for the actual hash calculation. This method will map to the
/// one in the C library, passing the necessary values to the C library via dart:ffi.
/// This method is used in the [getHash] method and maps to the Dart method [_Argon2Hash].
///
/// This method returns an [Int32] which maps to a Dart [int] for the error/result code.
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

/// The Dart function definition for [_argon2_hash], and is used to bind the C types
/// to given Dart inputs.
///
/// All parameters are named in symmetry with the C library's name. [t_cost] refers to the
/// iteration count. [m_cost] refers to the memory cost. [parallelism] refers to the thread
/// count. [pwd] is a [Uint8] pointer for the password byte. [pwdlen] refers to the length
/// of the password pointer. [salt] is a [Uint8] pointer for the salt bytes. [saltlen] refers
/// to the length of the salt. [hash] is the [Uint8] pointer to write the hash to. [hashlen]
/// refers to the length of the hash. [encoded] is the [Uint8] pointer to write the encoded
/// hash to. [encodedlen] refers to the length of the encoded hash. [type] refers to the
/// Argon2 Type used. [version] refers to the Argon2 Version.
///
/// Returns an [int] with the result code for the hash, while the real raw hash & encoded hashes
/// are written to the [hash] and [encoded] pointers respectively.
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

/// A function definition for the Argon2 hash verification. This method will map to the
/// one in the C library, passing the necessary values to the C library via dart:ffi.
/// This method is used in the [verifyHash] method and maps to the Dart method [_Argon2Verify].
///
/// This method returns an [Int32] which maps to a Dart [int] for the true/false output.
typedef _argon2_verify = Int32 Function(
  Pointer<Utf8> encoded,
  Pointer<Uint8> pwd,
  IntPtr pwdlen,
  Uint32 type,
);

/// The Dart function definition for [_argon2_verify], and is used to bind the C types
/// to given Dart inputs.
///
/// All parameters are named in symmetry with the C library's name. [pwd] is a [Uint8] pointer for the password byte. [pwdlen] refers to the length
/// of the password pointer. [encoded] is the [Utf8] pointer to write the encoded
/// hash to. [type] refers to the Argon2 Type used.
///
/// Returns an [int] with the result of the verification process. A return value of 0
/// indicates a true verification and others will indicate a false verification or error.
typedef _Argon2Verify = int Function(
    Pointer<Utf8> encoded, Pointer<Uint8> pwd, int pwdlen, int type);

/// A function definition for the Argon2 encoded length. This method will map to the
/// one in the C library, passing the necessary values to the C library via dart:ffi.
/// This method is used in the [getEncodedHashLength] method and maps to the Dart method [_Argon2Encodedlen].
///
/// This method returns an [IntPtr] which maps to a Dart [int] for the length of the encoded hash
typedef _argon2_encodedlen = IntPtr Function(Uint32 t_cost, Uint32 m_cost,
    Uint32 parallelism, Uint32 saltlen, Uint32 hashlen, Uint32 type);

/// The Dart function definition for [_argon2_encodedlen], and is used to bind the C types
/// to given Dart inputs.
///
/// All parameters are named in symmetry with the C library's name. [t_cost] refers to the iteration
/// count. [m_cost] refers to the memory cost. [parallelism] refers to the thread count. [saltlen]
/// refers to the length of the given salt. [hashlen] refers to the raw hash's length. [type]
/// refers to the Argon2 Hash Type (i, d, or id).
///
/// Returns an [int], signifying the length of the encoded hash.
typedef _Argon2Encodedlen = int Function(int t_cost, int m_cost,
    int parallelism, int saltlen, int hashlen, int type);

/// A function definition for the Argon2 error message getter. This method will map to the
/// one in the C library, passing the necessary values to the C library via dart:ffi.
/// This method is used in the [getErrorMessage] method and maps to the Dart method [_Argon2ErrorMessage].
///
/// This method returns an [Int32] which maps to a Dart [int] for the length of the encoded hash
typedef _argon2_error_message = Pointer<Utf8> Function(Int32 error_code);

/// The Dart function definition for [_argon2_error_message], and is used to bind the C types
/// to given Dart inputs.
///
/// All parameters are named in symmetry with the C library's name. [error_code] refers to the
/// error code that we are getting the message for.
///
/// Returns an [Pointer] of type [Utf8], signifying the error message string.
typedef _Argon2ErrorMessage = Pointer<Utf8> Function(int error_code);

/// The main class to handle communication between the C methods and their Dart bindings.
/// Unless users are working on a low level and need to directly change the bindings or paths,
/// there should be no reason to change this.
class LocalBinder {
  /// Create an instanced class in order to allow the dylib to stay loaded through the session.
  static LocalBinder _privateInstance;

  /// Callable method of type [_Argon2Hash] that binds to [_argon2_hash].
  _Argon2Hash getHash;

  /// Callable method of type [_Argon2Verify] that binds to [_argon2_verify].
  _Argon2Verify verifyHash;

  /// Callable method of type [_Argon2Encodedlen] that binds to [_argon2_encodedlen].
  _Argon2Encodedlen getEncodedHashLength;

  /// Callable method of type [_Argon2ErrorMessage] that binds to [_argon2_error_message].
  _Argon2ErrorMessage getErrorMessage;

  /// The getter for the main instance, which returns the private instance if set correctly.
  /// If not, a new Instance is created and set as the private instance, then returned.
  static LocalBinder get instance {
    _privateInstance ??= LocalBinder();
    return _privateInstance;
  }

  /// The class constructor, which handles loading the dylib and mapping each method to their
  /// respective C equivalents
  ///
  /// Takes an optional String [path] in case any user needs to override the path of the dylib,
  /// or need to privide their own.
  LocalBinder({String path}) {
    path ??= _getPath();
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
    getErrorMessage = argon2lib
        .lookup<NativeFunction<_argon2_error_message>>('argon2_error_message')
        .asFunction<_Argon2ErrorMessage>();
  }

  /// The private getPath method, set to handle paths from all 3 Desktop platforms as well as
  /// for Flutter apps. Returns the relative library location for desktops, or the necessary
  /// NDK set library as according to Flutter's guide on ffi
  String _getPath() {
    var relativePath = './lib/src/blobs';
    if (Platform.isMacOS) return '$relativePath/libargon2-darwin.dylib';
    if (Platform.isLinux) return '$relativePath/libargon2-linux.so';
    if (Platform.isWindows) return r'lib\src\blobs\libargon2-win.dll';
    return 'libargon2-arm.so';
  }
}
