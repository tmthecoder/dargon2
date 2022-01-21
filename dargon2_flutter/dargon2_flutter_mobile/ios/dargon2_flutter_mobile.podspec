# Copyright 2020 Tejas Mehta <tmthecoder@gmail.com>
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Pod::Spec.new do |s|
  s.name             = 'dargon2_flutter_mobile'
  s.version          = '1.2.0'
  s.summary          = 'The Flutter Implementation of dargon2'
  s.description      = <<-DESC
  Dargon2_flutter is the Flutter implementation of dargon2, which is a plugin built
  using dart to hash with the Password Hashing Algorithm, Argon2.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Tejas Mehta' => 'tmthecoder@gmail.com' }
  s.source           = { :path => '.' }

  s.source_files =
    'Classes/Dargon2FlutterMobilePlugin.h',
    'Classes/Dargon2FlutterMobilePlugin.m'

  s.dependency 'Flutter'
  s.dependency 'Argon2Swift'
  s.platform = :ios, '9.0'
  s.public_header_files = 'Classes/Dargon2FlutterMobilePlugin.h'
  s.source_files =
    "Classes/Dargon2FlutterMobilePlugin.h",
    "Classes/Dargon2FlutterMobilePlugin.m"
  s.requires_arc = true
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'LIBRARY_SEARCH_PATHS[sdk=*]' => '$(TOOLCHAIN_DIR)/usr/lib/swift/$(PLATFORM_NAME)',
  }
  s.swift_version = '5.0'
end
