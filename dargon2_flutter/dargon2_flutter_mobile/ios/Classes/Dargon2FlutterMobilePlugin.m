// Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "dargon2_flutter_mobile/Dargon2FlutterMobilePlugin.h"
#import <Argon2Swift/argon2.h>

@implementation Dargon2FlutterMobilePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"dargon2_flutter_mobile"
            binaryMessenger:[registrar messenger]];
  Dargon2FlutterMobilePlugin* instance = [[Dargon2FlutterMobilePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
  //Call these all once in order to pass them through to flutter because it doesn't work otherwise
  argon2_hash(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x13);
  argon2_encodedlen(0, 0, 0, 0, 0, 0);
  argon2_verify(0, 0, 0, 0);
  argon2_error_message(0);
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  result(FlutterMethodNotImplemented);
}

@end
