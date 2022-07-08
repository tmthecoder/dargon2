// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:dargon2_core/dargon2_core.dart';
// ignore: deprecated_member_use
import 'dart:cli';

/// The Dylib Loader for any Dart native apps, regardless of platform. Loads the dylib
/// from the given path, based off a conditional import on dart:ui
class DartLibLoader implements LibLoader {
  /// General library loader method, overridden from the abstract superclass
  ///
  /// Takes a given String [path], which is the Library's location
  ///
  /// Returns a [DynamicLibrary], which is the Argon2 Library
  @override
  DynamicLibrary loadLib() {
    return DynamicLibrary.open(getPath());
  }

  /// The private getPath method, set to handle paths from all 3 Desktop platforms.
  /// Returns the relative library location for desktops based on the plugin's location
  /// and the binary's relative path
  @override
  String getPath() {
    final rootLibrary = 'package:dargon2/dargon2.dart';
    // ignore: deprecated_member_use
    var rootPath = waitFor(Isolate.resolvePackageUri(Uri.parse(rootLibrary)))!
        .resolve('src/blobs/')
        .toFilePath(windows: Platform.isWindows);
    if (Platform.isMacOS) return '${rootPath}libargon2-darwin.dylib';
    if (Platform.isLinux) return '${rootPath}libargon2-linux.so';
    if (Platform.isWindows) return '${rootPath}libargon2-win.dll';
    return 'libargon2-arm.so';
  }
}
