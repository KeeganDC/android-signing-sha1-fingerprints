# android_signing_sha1_fingerprints

A small Android-only Flutter plugin that returns the SHA-1 fingerprint(s) of
the signer(s) on the currently installed app APK.

## Install

Add the package to your Flutter app:

```shell
flutter pub add android_signing_sha1_fingerprints
```

The Android plugin requires **Android API 28 (Android 9) or newer**. No runtime
permission or manifest permission is required.

## API

```dart
import 'package:android_signing_sha1_fingerprints/android_signing_sha1_fingerprints.dart';

final List<String> fingerprints = await activeSha1Fingerprints();
```

Each result is an uppercase, colon-delimited SHA-1 fingerprint, such as
`12:34:AB:...`. If the installed APK has multiple active signers, each signer
has one entry. On non-Android platforms, this method throws `UnsupportedError`.

## Signing and Play App Signing

The values are computed from the installed package's
`SigningInfo.apkContentsSigners`. They describe the active signer(s) of the
installed APK, not past or signing-lineage certificates. Consequently, debug,
locally released, and store-installed builds may report different fingerprints.

With Google Play App Signing, Google signs the APKs delivered to users with the
app-signing key. The fingerprint reported by this plugin on a Play-installed
app is therefore generally the **Play app-signing certificate** fingerprint,
not the upload-key fingerprint. Compare like-for-like artifacts when
configuring OAuth clients or APIs.

Fingerprints are returned to the calling app and are never logged by the
plugin. Treat them as identifying metadata, not as proof that an app or device
is trustworthy.

## Example

See [`example/`](example/) for a minimal app that displays the installed
signer fingerprints. Run it on Android 9 or newer:

```shell
cd example
flutter run
```

## Development

Run the Dart tests with `flutter test`. The Android fingerprint formatter also
has a focused local unit test in `android/src/test`. To run it, first build the
example app so Flutter generates its Gradle wrapper, then invoke the test:

```shell
cd example
flutter build apk --debug
cd android
./gradlew :android_signing_sha1_fingerprints:testDebugUnitTest
```
