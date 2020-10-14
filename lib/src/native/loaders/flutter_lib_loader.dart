/*
 * Made by Tejas Mehta
 * Made on Tuesday, October 13, 2020
 * File Name: flutter_lib_loader.dart
*/

import 'dart:ffi';
import 'dart:io';

import 'package:argon2_dart/src/native/loaders/lib_loader.dart';

class FlutterLibLoader implements LibLoader {
  @override
  DynamicLibrary loadLib(String path) {
    if (Platform.isIOS || Platform.isMacOS) {
      return DynamicLibrary.process();
    }
    return DynamicLibrary.open(path);
  }
}
LibLoader getLibLoader() => FlutterLibLoader();