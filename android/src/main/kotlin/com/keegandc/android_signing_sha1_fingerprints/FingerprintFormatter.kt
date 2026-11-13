package com.keegandc.android_signing_sha1_fingerprints

import java.security.MessageDigest
import java.util.Locale

internal object FingerprintFormatter {
    fun sha1(certificateBytes: ByteArray): String {
        val digest = MessageDigest.getInstance("SHA-1").digest(certificateBytes)
        return digest.joinToString(":") { byte ->
            "%02X".format(Locale.ROOT, byte.toInt() and 0xFF)
        }
    }
}
