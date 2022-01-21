// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'package:dargon2_core/dargon2_core.dart';
import 'package:dargon2_flutter_platform_interface/dargon2_flutter_platform.dart';

import 'native/flutter_lib_loader.dart';

/// The mobile [PlatformInterface] of [DArgon2]. Loads argon2 with
/// a [FlutterLibLoader], which utilized the supplied platform C binaries
/// over Dart FFI.
class DArgon2Mobile extends DArgon2Platform {
  /// The loaded instance of [DArgon2], which is a [DArgon2Native] instance
  /// as opposed to the web variant. This instance requires a
  /// [FlutterLibLoader]
  DArgon2 argon2 = DArgon2Native(FlutterLibLoader());

  /// Register the plugin's platform instance as an instance of this class,
  /// [DArgon2Mobile].
  static void registerWith() {
    DArgon2Platform.instance = DArgon2Mobile();
  }

  @override
  Future<DArgon2Result> hashPasswordBytes(List<int> password,
          {required Salt salt,
          int iterations = 32,
          int memory = 256,
          int parallelism = 2,
          int length = 32,
          Argon2Type type = Argon2Type.i,
          Argon2Version version = Argon2Version.V13}) =>
      argon2.hashPasswordBytes(password,
          salt: salt,
          iterations: iterations,
          memory: memory,
          parallelism: parallelism,
          length: length,
          type: type,
          version: version);

  @override
  Future<bool> verifyHashBytes(List<int> password, List<int> encodedHash,
          {Argon2Type type = Argon2Type.i}) =>
      argon2.verifyHashBytes(password, encodedHash, type: type);
}
