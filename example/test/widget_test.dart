import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:android_signing_sha1_fingerprints_example/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('android_signing_sha1_fingerprints');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final originalPlatform = debugDefaultTargetPlatformOverride;

  tearDown(() {
    debugDefaultTargetPlatformOverride = originalPlatform;
    messenger.setMockMethodCallHandler(channel, null);
  });

  testWidgets('displays the active signer fingerprints', (tester) async {
    messenger.setMockMethodCallHandler(
      channel,
      (call) async => <String>['01:AB:CD'],
    );
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    await tester.pumpWidget(const FingerprintsExampleApp());
    await tester.pumpAndSettle();
    debugDefaultTargetPlatformOverride = originalPlatform;

    expect(find.text('01:AB:CD'), findsOneWidget);
  });
}
