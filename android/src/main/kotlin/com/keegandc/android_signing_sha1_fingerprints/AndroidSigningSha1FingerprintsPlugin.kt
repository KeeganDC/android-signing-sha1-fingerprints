package com.keegandc.android_signing_sha1_fingerprints

import android.content.pm.PackageManager
import android.content.pm.Signature
import android.os.Build
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AndroidSigningSha1FingerprintsPlugin */
class AndroidSigningSha1FingerprintsPlugin :
    FlutterPlugin,
    MethodCallHandler {
    private var applicationContext: android.content.Context? = null
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext
        channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "android_signing_sha1_fingerprints",
        )
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(
        call: MethodCall,
        result: Result
    ) {
        when (call.method) {
            "activeSha1Fingerprints" -> result.success(activeSha1Fingerprints())
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        applicationContext = null
    }

    private fun activeSha1Fingerprints(): List<String> {
        check(Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            "Android API 28 or newer is required."
        }
        val context = checkNotNull(applicationContext) {
            "Plugin is not attached to an Android engine."
        }

        val packageInfo = context.packageManager.getPackageInfo(
            context.packageName,
            PackageManager.GET_SIGNING_CERTIFICATES,
        )
        val signers: Array<Signature> =
            packageInfo.signingInfo?.apkContentsSigners ?: emptyArray()

        return signers.map { FingerprintFormatter.sha1(it.toByteArray()) }
    }
}
