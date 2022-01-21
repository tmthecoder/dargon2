// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'package:dargon2_flutter/dargon2_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
void main() {
  // This line is necessary if you're using a Flutter version under 2.8
  DArgon2Flutter.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Declare main controller and hash strings
  TextEditingController _passController = TextEditingController();
  String _base64Hash = "";
  String _hexHash = "";
  String _encodedString = "";

  /// Main build method, build the [Scaffold] with aa [Column], [TextField] and [Text] objects to
  /// allow the user to test Argon2 hashing
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('dargon2_flutter example'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: TextField(
                  controller: _passController,
                  decoration:
                      InputDecoration(hintText: "Enter a value to hash"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              ElevatedButton(
                child: Text("Hash With Argon2"),
                onPressed: _hash,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              Text(
                "Hash Values",
                style: Theme.of(context).textTheme.headline6,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              Text(
                "Base64 Hash\n$_base64Hash",
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              Text(
                "Hex Hash\n$_hexHash",
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              Text(
                "Encoded String\n$_encodedString",
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }

  /// A simple hashing test method for argon2.
  /// It takes the text from the controller and passes it through to the dargon2 plugin,
  /// returning the hashed result.
  void _hash() async {
    //Hash the given text and show the results
    DArgon2Result result =
        await argon2.hashPasswordString(_passController.text, salt: Salt.newSalt());
    _base64Hash = result.base64String;
    _hexHash = result.hexString;
    _encodedString = result.encodedString;
    setState(() {});

    // Call the compute hash
    compute(hashWithArgon2Isolate, {
      "hashString": "Test hash string"
    });
  }
}

Future<void> hashWithArgon2Isolate(Map<String, String> map) async {
  DArgon2Flutter.init();
  DArgon2Result result =
      await argon2.hashPasswordString(map["hashString"]!, salt: Salt.newSalt());
  print("Hex String: ${result.hexString}");
  print("Base64 String: ${result.base64String}");
  print("Encoded String: ${result.encodedString}");
}
