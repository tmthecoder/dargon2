// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:ffi';

/// The abstract superclass for the two LibLoader classes. Used
/// to split the loader between Dart native and Flutter as the paths for
/// the dylib are different.
abstract class LibLoader {
  /// The abstract library loader method, which is overridden in
  /// subclasses when implementing
  DynamicLibrary loadLib();

  /// The private getPath method, set to handle paths from all 3 Desktop platforms as well as
  /// for Flutter apps. Returns the relative library location for desktops, or the necessary
  /// NDK set library as according to Flutter's guide on ffi
  String getPath();
}
