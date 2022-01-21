// Copyright 2021 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'package:dargon2_flutter_platform_interface/dargon2_flutter_platform.dart';
import 'package:dargon2_interface/dargon2_interface.dart';

/// The empty [DArgon2Platform] implementation to default to when no platform
/// provides bindings to set to.
class EmptyDArgon2Flutter extends DArgon2Platform {
  @override
  Future<DArgon2Result> hashPasswordBytes(List<int> password,
      {required Salt salt,
      int iterations = 32,
      int memory = 256,
      int parallelism = 2,
      int length = 32,
      Argon2Type type = Argon2Type.i,
      Argon2Version version = Argon2Version.V13}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> verifyHashBytes(List<int> password, List<int> encodedHash,
      {Argon2Type type = Argon2Type.i}) {
    throw UnimplementedError();
  }
}
