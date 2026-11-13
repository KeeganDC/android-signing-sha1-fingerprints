import 'package:android_signing_sha1_fingerprints/android_signing_sha1_fingerprints.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FingerprintsExampleApp());
}

class FingerprintsExampleApp extends StatelessWidget {
  const FingerprintsExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Installed app signing SHA-1')),
        body: Center(
          child: FutureBuilder<List<String>>(
            future: activeSha1Fingerprints(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Unable to read fingerprints: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              if (snapshot.data!.isEmpty) {
                return const Text('No active APK signers found.');
              }
              return SelectableText(snapshot.data!.join('\n'));
            },
          ),
        ),
      ),
    );
  }
}
