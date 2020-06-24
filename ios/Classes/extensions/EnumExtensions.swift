//
//  EnumExtensions.swift
//  pingidsdk
//
//  Created by Sandro Caseiro on 6/19/20.
//

import Foundation



extension PIDTrustLevel {
    var stringValue: String {
        switch self {
        case PIDTrustLevel.primary:
            return PIDTrustLevelValues.PIDTrustLevelPrimary.rawValue
        case PIDTrustLevel.trusted:
            return PIDTrustLevelValues.PIDTrustLevelTrusted.rawValue
        case PIDTrustLevel.ignored:
            fallthrough
        default:
            return PIDTrustLevelValues.PIDTrustLevelIgnored.rawValue
        }
    }
}

extension PIDError {
    var description: String {
        switch self {
        case PIDError.withPairing:
            return PIDErrorValues.PIDErrorWithPairing.rawValue
        case PIDError.appDisabled:
            return PIDErrorValues.PIDErrorAppDisabled.rawValue
        case PIDError.wrongAppID:
            return PIDErrorValues.PIDErrorWrongAppID.rawValue
        case PIDError.remoteNotificationTimeout:
            return PIDErrorValues.PIDErrorRemoteNotificationTimeout.rawValue
        case PIDError.noInternetConnection:
            return PIDErrorValues.PIDErrorNoInternetConnection.rawValue
        case PIDError.wrongSignature:
            return PIDErrorValues.PIDErrorWrongSignature.rawValue
        case PIDError.problemWithPublicKey:
            return PIDErrorValues.PIDErrorProblemWithPublicKey.rawValue
        case PIDError.missingPermissions:
            return PIDErrorValues.PIDErrorMissingPermissions.rawValue
        case PIDError.reachability:
            return PIDErrorValues.PIDErrorReachability.rawValue
        case PIDError.serverResponse:
            return PIDErrorValues.PIDErrorServerResponse.rawValue
        case PIDError.serverInternal:
            return PIDErrorValues.PIDErrorServerInternal.rawValue
        case PIDError.withServerPayload:
            return PIDErrorValues.PIDErrorWithServerPayload.rawValue
        case PIDError.selectionIsMissing:
            return PIDErrorValues.PIDErrorSelectionIsMissing.rawValue
        case PIDError.deviceTokenIsMissing:
            return PIDErrorValues.PIDErrorDeviceTokenIsMissing.rawValue
        case PIDError.expiredOrWrongAuthToken:
            return PIDErrorValues.PIDErrorExpiredOrWrongAuthToken.rawValue
        case PIDError.wrongAppIDFromAuthToken:
            return PIDErrorValues.PIDErrorWrongAppIDFromAuthToken.rawValue
        case PIDError.wrongAccountIDFromAuthToken:
            return PIDErrorValues.PIDErrorWrongAccountIDFromAuthToken.rawValue
        case PIDError.userIsSuspended:
            return PIDErrorValues.PIDErrorUserIsSuspended.rawValue
        case PIDError.usernameNotPairedForToken:
            return PIDErrorValues.PIDErrorUsernameNotPairedForToken.rawValue
        case PIDError.authTokenAlreadyUsed:
            return PIDErrorValues.PIDErrorAuthTokenAlreadyUsed.rawValue
        case PIDError.rootedDevice:
            return PIDErrorValues.PIDErrorRootedDevice.rawValue
        case PIDError.missingAppId:
            return PIDErrorValues.PIDErrorMissingAppId.rawValue
        case PIDError.internal:
            fallthrough
        default:
            return PIDErrorValues.PIDErrorInternal.rawValue
        }
        
    }
}

extension String {
    var asPIDTrustLevel: PIDTrustLevel {
        switch self {
        case PIDTrustLevelValues.PIDTrustLevelPrimary.rawValue:
            return PIDTrustLevel.primary
        case PIDTrustLevelValues.PIDTrustLevelTrusted.rawValue:
            return PIDTrustLevel.trusted
        case PIDTrustLevelValues.PIDTrustLevelIgnored.rawValue:
            fallthrough
        default:
            return PIDTrustLevel.ignored
        }
    }
    
    var asPIDActionType: PIDActionType {
        switch self {
        case PIDActionTypeValues.PIDActionTypeApprove.rawValue:
            return PIDActionType.approve
        case PIDActionTypeValues.PIDActionTypeBlock.rawValue:
            return PIDActionType.block
        case PIDActionTypeValues.PIDActionTypeDeny.rawValue:
            return PIDActionType.deny
        case PIDActionTypeValues.PIDActionTypeNone.rawValue:
            fallthrough
        default:
            return PIDActionType.none
        }
    }
}
