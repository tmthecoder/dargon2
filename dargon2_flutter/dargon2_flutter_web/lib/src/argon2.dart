// Copyright 2021 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'dart:typed_data';

import 'package:dargon2_flutter_platform_interface/dargon2_flutter_platform.dart';
import 'package:dargon2_interface/dargon2_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';

/// The web [PlatformInterface] of [DArgon2]. Loads argon2 through hashwasm's WebAssembly-based
/// implementation. Binds the dargon2 mappings to the JS ones.
class DArgon2FlutterWeb extends DArgon2Platform {
  /// The static [registerWith] method from flutter_web_plugins that
  /// makes this implementation the instance of [DArgon2Platform] used
  /// in-app
  static void registerWith(Registrar registrar) async {
    DArgon2Platform.instance = DArgon2FlutterWeb();
  }

  /// The static hashwasm URL to use when getting the script.
  static const hashwasm =
      "https://cdn.jsdelivr.net/npm/hash-wasm@4.8.0/dist/argon2.umd.min";

  /// The [DArgon2FlutterWeb] constructor. Needed to set the global hashwasm
  /// variable to the right script.
  DArgon2FlutterWeb() {
    if (context['require'] != null) {
      _registerRequire();
    } else {
      _registerNormal();
    }
  }

  @override
  Future<DArgon2Result> hashPasswordBytes(List<int> password,
      {required Salt salt,
      int iterations = 32,
      int memory = 256,
      int parallelism = 2,
      int length = 32,
      Argon2Type type = Argon2Type.i,
      Argon2Version version = Argon2Version.V13}) async {
    // Create a JS-interp set of parameters for hashwasm's implementation with
    // the given parameters
    var params = _HashParams(
        password: Uint8List.fromList(password),
        salt: Uint8List.fromList(salt.bytes),
        iterations: iterations,
        memorySize: memory,
        parallelism: parallelism,
        hashLength: length,
        outputType: 'encoded');

    // Get the encoded hash based on the type above
    try {
      String encoded;
      switch (type) {
        case Argon2Type.i:
          encoded = await promiseToFuture(_argon2iHash(params));
          break;
        case Argon2Type.d:
          encoded = await promiseToFuture(_argon2dHash(params));
          break;
        case Argon2Type.id:
          encoded = await promiseToFuture(_argon2idHash(params));
          break;
      }
      // Normalize the hash portion of the encoded hash
      var hash = _normalizeB64(encoded.split('\$').last);
      // Return a DArgon2Result object
      return DArgon2Result(base64Decode(hash), utf8.encode(encoded));
    } catch (e) {
      // Throw whichever exception ocurred
      throw DArgon2Exception(
          e.toString(), DArgon2ErrorCode.ARGON2_UNKNOWN_ERROR);
    }
  }

  @override
  Future<bool> verifyHashBytes(List<int> password, List<int> encodedHash,
      {Argon2Type type = Argon2Type.i}) {
    try {
      // Try to hash verify the given password and hash
      return promiseToFuture(_verify(_VerificationParams(
        password: Uint8List.fromList(password),
        hash: utf8.decode(encodedHash),
      )));
    } catch (e) {
      throw DArgon2Exception(
          e.toString(), DArgon2ErrorCode.ARGON2_UNKNOWN_ERROR);
    }
  }

  /// A method to normalize a base64-encoded string by adding '=' as needed
  /// Needed as Dart won't successfully decode the string unless it's padded
  /// correctly. Returns a [String] with correctly-padded base64
  String _normalizeB64(String source) {
    var current = source;
    while (current.length % 4 != 0) {
      current += '=';
    }
    return current;
  }

  /// Registers the hashwasm argon2 implementation in release or script-loaded
  /// environments by adding a script tag with the dependency.
  void _registerNormal() async {
    print("NORMAL");
    // Create the script element
    ScriptElement script = ScriptElement();
    script.type = "text/javascript";
    script.charset = "utf-8";
    script.async = true;
    script.src = "$hashwasm.js";
    // Add it to the document head
    assert(document.head != null);
    document.head!.append(script);
    // await its load
    await script.onLoad.first;
  }

  /// Registers the hashwasm argon2 implementation in debug or requirejs loaded
  /// environments as adding the script tag would not suffice then.
  ///
  /// Adds it as a require.js dependency and sets the global hashwasm variable
  /// to the require app.
  void _registerRequire() async {
    // Make sure it's not already there
    if (context['hashwasm'] != null) return;
    // Get the require object
    JsObject require = JsObject.fromBrowserObject(context['require']);
    // Add the script to the config
    require.callMethod('config', [
      JsObject.jsify({
        'paths': {"hashwasm": hashwasm}
      })
    ]);
    Completer completer = Completer();
    List<String> services = ['hashwasm'];
    // Load the script
    context.callMethod('require', [
      JsObject.jsify(services),
      (app) {
        // Set it to the global variable
        context['hashwasm'] = app;
        completer.complete();
      }
    ]);
    await completer.future;
  }
}

/// JS interop binding to call the hashwasm argon2i hash function.
@JS('hashwasm.argon2i')
external _Promise<String> _argon2iHash(_HashParams params);

/// JS interop binding to call the hashwasm argon2d hash function.
@JS('hashwasm.argon2d')
external _Promise<String> _argon2dHash(_HashParams params);

/// JS interop binding to call the hashwasm argon2id hash function.
@JS('hashwasm.argon2id')
external _Promise<String> _argon2idHash(_HashParams params);

/// JS interop binding to call the hashwasm argon2Cerify function.
@JS('hashwasm.argon2Verify')
external _Promise<bool> _verify(_VerificationParams params);

/// A generic class to provide JS Promise support.
@JS('Promise')
class _Promise<T> {
  external factory _Promise._();
}

/// A wrapper class to provide the hash parameters from dargon2's mapping
/// into a JSON-style object with each parameter mapping to the hashwasm
/// equivalent. Exact JS mapping is below.
@JS()
@anonymous
class _HashParams {
  /* From JS:
    password: IDataType; // password (or message) to be hashed
    salt: IDataType; // salt (usually containing random bytes)
    iterations: number; // number of iterations to perform
    parallelism: number; // degree of parallelism
    memorySize: number; // amount of memory to be used in kibibytes (1024 bytes)
    hashLength: number; // output size in bytes
    outputType?: 'hex' | 'binary' | 'encoded'; // by default returns hex string
   */

  /// The factory constructor that takes our typed parameters.
  external factory _HashParams(
      {Uint8List password,
      Uint8List salt,
      int iterations,
      int parallelism,
      int memorySize,
      int hashLength,
      String outputType});
}

/// A wrapper class to provide the verification parameters from dargon2's
/// mapping into a JSON-style object with each parameter mapping to the
/// hashwasm equivalent. Exact JS mapping is below.
@JS()
@anonymous
class _VerificationParams {
  /* From JS:
    password: IDataType, // password
    hash: string, // encoded hash
   */

  external factory _VerificationParams({Uint8List password, String hash});
}
