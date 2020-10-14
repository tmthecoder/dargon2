/*
 * Made by Tejas Mehta
 * Made on Tuesday, October 13, 2020
 * File Name: dart_lib_loader.dart
*/

import 'dart:ffi';

import 'package:dargon2/src/native/loaders/lib_loader.dart';

class DartLibLoader implements LibLoader {
  @override
  DynamicLibrary loadLib(String path) {
    return DynamicLibrary.open(path);
  }
}
LibLoader getLibLoader() => DartLibLoader();