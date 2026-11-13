import 'package:android_signing_sha1_fingerprints/android_signing_sha1_fingerprints.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

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

  test('returns active signer fingerprints from the Android channel', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    const fingerprints = <String>['01:AB:CD', 'FE:DC:BA'];
    messenger.setMockMethodCallHandler(channel, (call) async {
      expect(call.method, 'activeSha1Fingerprints');
      return fingerprints;
    });

    expect(await activeSha1Fingerprints(), fingerprints);
  });

  test('throws UnsupportedError outside Android', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    await expectLater(
      activeSha1Fingerprints(),
      throwsA(isA<UnsupportedError>()),
    );
  });
}
