import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

import 'package:dargon2_flutter_example/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('dargon2_flutter Tests', () {
    testWidgets('Test 1 - Password: password, Salt: somesalt',
            (WidgetTester tester) async {
          expect(await getEncodedHash(tester, "password", "somesalt"),
              "\$argon2i\$v=19\$m=256,t=32,p=2\$c29tZXNhbHQ\$wxqz54yTDqhGKcTe4g4AhcjIM2rL8+CRm/cToHmBwo4"
          );
    });
    testWidgets('Test 2 - Password: adifferentpassword, Salt: somesalt',
            (WidgetTester tester) async {
          expect(await getEncodedHash(tester, "adifferentpassword", "somesalt"),
              "\$argon2i\$v=19\$m=256,t=32,p=2\$c29tZXNhbHQ\$iz9v0NbPE3KlH+JyjuQ8FT/zBsWeDn3/FFURLCnk9s0"
          );
    });
    testWidgets('Test 3 - Password: password, Salt: adifferentsalt',
            (WidgetTester tester) async {
          expect(await getEncodedHash(tester, "password", "adifferentsalt"),
              "\$argon2i\$v=19\$m=256,t=32,p=2\$YWRpZmZlcmVudHNhbHQ\$xTUGyeSvH+c8ss2pFpe9qPovrEUGB2oBi4NZZmlG7VM"
          );
    });
    testWidgets('Test 4 - Password: adifferentpassword, Salt: adifferentsalt',
            (WidgetTester tester) async {
          expect(await getEncodedHash(tester, "adifferentpassword", "adifferentsalt"),
              "\$argon2i\$v=19\$m=256,t=32,p=2\$YWRpZmZlcmVudHNhbHQ\$qrZf7a27IhS3n0yXxo1niBLciHsHR7s54SwLus4+zxw"
          );
    });
  });
}

Future<String> getEncodedHash(WidgetTester tester, String password, String salt) async {
  app.main();
  await tester.pumpAndSettle();

  // find all entry fields
  final hashEntryField = find.byKey(Key("hashEntry"));
  final saltEntryField = find.byKey(Key("saltEntry"));
  final hashButton = find.byKey(Key("hash"));
  final hashText = find.byKey(Key("hashText"));

  await tester.tap(hashEntryField);
  await tester.enterText(hashEntryField, password);
  await tester.tap(saltEntryField);
  await tester.enterText(saltEntryField, salt);
  await tester.tap(hashButton);

  await tester.pumpAndSettle();

  return (tester.widget(hashText) as Text).data!
      .replaceAll("Encoded String\n", "");
}
