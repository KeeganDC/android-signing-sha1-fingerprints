import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel(
  'android_signing_sha1_fingerprints',
);

/// Returns the SHA-1 fingerprints of this installed Android app's active
/// signer(s), as uppercase colon-delimited hexadecimal strings.
///
/// The result describes the signers of the installed APK and does not include
/// certificate history. This API is Android-only and throws [UnsupportedError]
/// on other platforms.
Future<List<String>> activeSha1Fingerprints() async {
  if (defaultTargetPlatform != TargetPlatform.android) {
    throw UnsupportedError(
      'activeSha1Fingerprints() is only supported on Android.',
    );
  }

  final fingerprints = await _channel.invokeListMethod<String>(
    'activeSha1Fingerprints',
  );
  if (fingerprints == null) {
    throw PlatformException(
      code: 'unexpected_response',
      message: 'The Android plugin returned no signer fingerprint list.',
    );
  }
  return fingerprints;
}
