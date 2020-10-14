/*
 * Made by Tejas Mehta
 * Made on Tuesday, October 13, 2020
 * File Name: lib_loader.dart
*/

import 'dart:ffi';
import 'lib_loader_stub.dart'
  if (dart.library.ui) 'flutter_lib_loader.dart'
  if (dart.library.io) 'dart_lib_loader.dart';

abstract class LibLoader {
  DynamicLibrary loadLib(String path);
  factory LibLoader() => getLibLoader();
}