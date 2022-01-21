import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dargon2_flutter_desktop/dargon2_flutter_desktop.dart';

void main() {
  const MethodChannel channel = MethodChannel('dargon2_flutter_desktop');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Dargon2FlutterDesktop.platformVersion, '42');
  });
}
