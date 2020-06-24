//
//  Constants.swift
//  pingidsdk
//
//  Created by Sandro Caseiro on 6/18/20.
//

import Foundation

enum PingEvents: String {
	case GET_PAYLOAD = "getPayload";
	case SERVER_PAYLOAD = "serverPayload"
	case PAIRING_SELECTION = "pairingSelection"
	case AUTHENTICATION_SELECTION = "authenticationSelection"
	case DEVICE_IS_TRUSTED = "deviceIsTrusted"
}

enum ServerPayloadArgs: String {
    case PAYLOAD = "payload"
}

enum PairingSelectionArgs: String {
    case TRUST_LEVEL = "trustLevel"
    case ACTION = "action"
    case USERNAME = "username"
}

enum AuthenticationSelectionArgs: String {
    case ACTION = "action"
    case USERNAME = "username"
}

enum FlutterMethods: String {
    //Pairing
    case PAIRING_OPTIONS_REQUIRED = "onPairingOptionsRequired"
    case PAIRING_COMPLETED = "onPairingCompleted"
    case DID_UNTRUST_DEVICE = "didUntrustDevice"
    //Authentication
    case AUTHENTICATION_REQUIRED = "onAuthenticationRequired"
    case AUTHENTICATION_COMPLETED = "onAuthenticationCompleted"
    case AUTHENTICATION_CANCELLED = "onAuthenticationCancelled"
    case ONE_TIME_PASSWORD_CHANGED = "onOneTimePasscodeChanged"
    case AUTHENTICATION_TOKEN_STATUS = "authenticationTokenStatus"
}

enum PairingOptionsRequiredArgs: String {
    case AVAILABLE_TRUST_LEVELS = "availableTrustLevels"
    case DEVICE_NAME = "deviceName"
}

enum PairingCompletedArgs: String {
    case ACTION_STATUS = "actionStatus"
    case ERROR = "error"
}

enum AuthenticationRequiredArgs: String {
    case DATA = "data"
}

enum AuthenticationCompletedArgs: String {
    case ACTION_STATUS = "actionStatus"
    case ACTION = "action"
    case ERROR = "error"
}

enum OneTimePasswordChangedArgs: String {
    case OTP = "otp"
}

enum AuthenticationTokenStatusArgs: String {
    case DATA = "data"
    case ERROR = "error"
}

//Ping Enums
enum PIDTrustLevelValues: String {
    case PIDTrustLevelPrimary = "IS_PRIMARY"
    case PIDTrustLevelTrusted = "IS_TRUSTED"
    case PIDTrustLevelIgnored = "IGNORE"
}

enum PIDActionTypeValues: String {
    case PIDActionTypeNone = "none"
    case PIDActionTypeApprove = "approve"
    case PIDActionTypeDeny = "deny"
    case PIDActionTypeBlock = "block"
}

enum PIDActionStatusValues: String {
    case SUCCESS = "SUCCESS"
    case FAILURE = "FAILURE"
    case RE_PAIR_SUCCESS = "RE_PAIR_SUCCESS"
}

enum PIDErrorValues: String {
    case PIDErrorInternal = "PIDInternalError"
    case PIDErrorWithPairing = "PIDErrorWithPairing"
    case PIDErrorAppDisabled = "PIDErrorAppDisabled"
    case PIDErrorWrongAppID = "PIDErrorWrongAppID"
    case PIDErrorRemoteNotificationTimeout = "PIDErrorTimeout"
    case PIDErrorNoInternetConnection = "PIDErrorNoInternetConnection"
    case PIDErrorWrongSignature = "PIDErrorWrongSignature"
    case PIDErrorProblemWithPublicKey = "PIDErrorProblemWithPublicKey"
    case PIDErrorMissingPermissions = "PIDMissingPermissions"
    case PIDErrorReachability = "PIDErrorReachability"
    case PIDErrorServerResponse = "PIDErrorServerResponse"
    case PIDErrorServerInternal = "PIDErrorServerInternal"
    case PIDErrorWithServerPayload = "PIDErrorWithServerPayload"
    case PIDErrorSelectionIsMissing = "PIDErrorSelectionIsMissing"
    case PIDErrorDeviceTokenIsMissing = "PIDErrorDeviceTokenIsMissing"
    case PIDErrorExpiredOrWrongAuthToken = "PIDErrorExpiredOrWrongAuthToken"
    case PIDErrorWrongAppIDFromAuthToken = "PIDErrorWrongAppIDFromAuthToken"
    case PIDErrorWrongAccountIDFromAuthToken = "PIDErrorWrongAccountIDFromAuthToken"
    case PIDErrorUserIsSuspended = "PIDErrorUserIsSuspended"
    case PIDErrorUsernameNotPairedForToken = "PIDErrorUsernameNotPairedForToken"
    case PIDErrorAuthTokenAlreadyUsed = "PIDErrorAuthTokenAlreadyUsed"
    case PIDErrorRootedDevice = "PIDErrorDeviceRooted"
    case PIDErrorMissingAppId = "PIDErrorMissingAppId"
}
