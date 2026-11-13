import 'package:android_signing_sha1_fingerprints/android_signing_sha1_fingerprints.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  test('returns active signer fingerprints on Android', () async {
    final fingerprints = await activeSha1Fingerprints();
    expect(fingerprints, isA<List<String>>());
  });
}
