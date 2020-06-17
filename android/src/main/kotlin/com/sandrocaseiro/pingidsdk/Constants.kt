package com.sandrocaseiro.pingidsdk

object PingEvents {
    const val GET_PAYLOAD = "getPayload"
    const val SERVER_PAYLOAD = "serverPayload"
    const val PAIRING_SELECTION = "pairingSelection"
    const val AUTHENTICATION_SELECTION = "authenticationSelection"
    const val DEVICE_IS_TRUSTED = "deviceIsTrusted"
}

object ServerPayloadArgs {
    const val PAYLOAD = "payload"
}

object PairingSelectionArgs {
    const val TRUST_LEVEL = "trustLevel"
    const val ACTION = "action"
    const val USERNAME = "username"
}

object AuthenticationSelectionArgs {
    const val ACTION = "action"
    const val USERNAME = "username"
}

object FlutterMethods {
    //Pairing
    const val PAIRING_OPTIONS_REQUIRED = "onPairingOptionsRequired"
    const val PAIRING_OPTIONS_REQUIRED_WITH_PASSWORD = "onPairingOptionsRequiredWithPasscode"
    const val PAIRING_PROGRESS = "onPairingProgress"
    const val PAIRING_COMPLETED = "onPairingCompleted"
    const val IGNORE_DEVICE_COMPLETED = "onIgnoreDeviceCompleted"
    const val DID_UNTRUST_DEVICE = "didUntrustDevice"
    //Authentication
    const val AUTHENTICATION_REQUIRED = "onAuthenticationRequired"
    const val AUTHENTICATION_COMPLETED = "onAuthenticationCompleted"
    const val AUTHENTICATION_CANCELLED = "onAuthenticationCancelled"
    const val ONE_TIME_PASSWORD_CHANGED = "onOneTimePasscodeChanged"
    const val AUTHENTICATION_TOKEN_STATUS = "authenticationTokenStatus"
    //General
    const val SERVICE_PAYLOAD_RECEIVED_WITH_STATUS_DONE = "onServicePayloadReceivedWithStatusDone"
    const val LOGS_SENT_TO_SERVER = "onLogsSentToServer"
    const val GENERAL_MESSAGE = "onGeneralMessage"
    const val GOOGLE_PLAY_SERVICES_STATUS_RECEIVED = "onGooglePlayServicesStatusReceived"
    const val ERROR = "onError"
}

object PairingOptionsRequiredArgs {
    const val AVAILABLE_TRUST_LEVELS = "availableTrustLevels"
    const val DEVICE_NAME = "deviceName"
}

object PairingOptionsRequiredWithPasswordArgs {
    const val AVAILABLE_TRUST_LEVELS = "availableTrustLevels"
    const val DEVICE_NAME = "deviceName"
}

object PairingProgressArgs {
    const val MESSAGE = "message"
}

object PairingCompletedArgs {
    const val ACTION_STATUS = "actionStatus"
    const val ERROR = "error"
}

object IgnoreDeviceCompletedArgs {
    const val ACTION_STATUS = "actionStatus"
    const val ERROR = "error"
}

object AuthenticationRequiredArgs {
    const val DATA = "data"
}

object AuthenticationCompletedArgs {
    const val ACTION_STATUS = "actionStatus"
    const val ACTION = "action"
    const val ERROR = "error"
}

object OneTimePasswordChangedArgs {
    const val OTP = "otp"
}

object AuthenticationTokenStatusArgs {
    const val DATA = "data"
    const val ERROR = "error"
}

object LogsSentToServerArgs {
    const val ACTION_STATUS = "actionStatus"
    const val SUPPORT_ID = "supportId"
}

object GeneralMessageArgs {
    const val MESSAGE = "message"
}

object GooglePlayServicesStatusReceivedArgs {
    const val STATUS = "status"
}

object ErrorArgs {
    const val THROWABLE = "throwable"
    const val DESCRIPTION = "description"
}
