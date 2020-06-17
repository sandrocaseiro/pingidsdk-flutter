package com.sandrocaseiro.pingidsdk.extensions

import android.os.Bundle

fun Bundle.toMap(): Map<String, Any?> {
    val map = HashMap<String, Any?>()
    for (key in this.keySet()) {
        map[key] = this.get(key)
    }

    return map;
}
