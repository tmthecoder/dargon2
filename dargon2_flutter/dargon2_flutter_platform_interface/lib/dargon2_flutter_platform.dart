// Copyright 2021 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'package:dargon2_flutter_platform_interface/empty_dargon2_flutter.dart';
import 'package:dargon2_interface/dargon2_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The globally accessible instance of [DArgon2]. It provides all hashing and
/// verification functionality.
DArgon2 get argon2 => DArgon2Platform.instance;

/// The base [PlatformInterface] for all [dargon2_flutter] platform-specific
/// implementations to follow. Provides the hashing functionality through the
/// [DArgon2] mixin and federated functionality from [PlatformInterface].
abstract class DArgon2Platform extends PlatformInterface with DArgon2 {
  /// The token [Object] to pass to the [PlatformInterface.verifyToken] method.
  static final Object _token = Object();

  /// The empty constructor that passes on the token to the superclass.
  DArgon2Platform() : super(token: _token);

  /// The platform-specific instance of [DArgon2Platform]. Initially set to
  /// [EmptyDArgon2Flutter], and changed once a platform's bindings are loaded.
  static DArgon2Platform _instance = EmptyDArgon2Flutter();

  /// The default instance of [DArgon2Platform] to use.
  static DArgon2Platform get instance => _instance;

  /// The setter to change the instance of [DArgon2Platform] which will be
  /// returned by the [instance] getter and [argon2] global instance.
  static set instance(DArgon2Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
}
