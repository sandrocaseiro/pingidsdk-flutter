package com.sandrocaseiro.pingidsdk.extensions

import pingidsdkclient.PingID

fun String.toPIDTrustLevel() = when (this) {
        PingID.PIDTrustLevel.PIDTrustLevelPrimary.getName() -> PingID.PIDTrustLevel.PIDTrustLevelPrimary
        PingID.PIDTrustLevel.PIDTrustLevelTrusted.getName() -> PingID.PIDTrustLevel.PIDTrustLevelTrusted
        else -> PingID.PIDTrustLevel.PIDTrustLevelIgnored
    }

fun String.toPIDActionType() = when (this) {
    PingID.PIDActionType.PIDActionTypeApprove.getName() -> PingID.PIDActionType.PIDActionTypeApprove
    PingID.PIDActionType.PIDActionTypeBlock.getName() -> PingID.PIDActionType.PIDActionTypeBlock
    PingID.PIDActionType.PIDActionTypeDeny.getName() -> PingID.PIDActionType.PIDActionTypeDeny
    else -> PingID.PIDActionType.PIDActionTypeNone
}