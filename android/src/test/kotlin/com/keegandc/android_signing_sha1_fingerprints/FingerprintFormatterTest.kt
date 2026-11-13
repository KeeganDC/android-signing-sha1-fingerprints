package com.keegandc.android_signing_sha1_fingerprints

import kotlin.test.Test
import kotlin.test.assertEquals

internal class FingerprintFormatterTest {
    @Test
    fun sha1ReturnsUppercaseColonDelimitedDigest() {
        assertEquals(
            "DA:39:A3:EE:5E:6B:4B:0D:32:55:BF:EF:95:60:18:90:AF:D8:07:09",
            FingerprintFormatter.sha1(byteArrayOf()),
        )
    }
}
