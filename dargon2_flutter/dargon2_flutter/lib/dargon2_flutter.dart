// Copyright 2021 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

/// This plugin is the federated plugin for argon2 hashing functionality in Flutter.
/// It utilizes the Argon2 C reference implementation for mobile and the hash-wasm
/// WebAssembly implementation for web.
///
/// To use this library in your code, add the following import:
///
///     import 'package:dargon2_flutter/dartgon2_flutter.dart';
///
/// For detailed usage please look at the example
library dargon2_flutter;

export 'src/initializer.dart';

export 'package:dargon2_interface/dargon2_interface.dart';
export 'package:dargon2_flutter_platform_interface/dargon2_flutter_platform.dart'
    hide DArgon2Platform;
