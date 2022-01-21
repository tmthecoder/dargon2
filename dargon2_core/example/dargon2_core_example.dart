import 'dart:ffi';

import 'package:dargon2_core/dargon2_core.dart';

void main() {
  // Create an instance of DArgon2
  final argon2 = DArgon2Native(TestLibLoader());
}

class TestLibLoader implements LibLoader {
  @override
  String getPath() {
    // Return the Argon2 Reference Library's path here
    throw UnimplementedError();
  }

  @override
  DynamicLibrary loadLib() {
    // Return the actual loaded DynamicLibary here
    throw UnimplementedError();
  }
}
