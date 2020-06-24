class NativeMethods {
  static const String GET_PAYLOAD = 'getPayload';
  static const String SEND_SERVER_PAYLOAD = 'serverPayload';
  static const String PAIRING_SELECTION = 'pairingSelection';
  static const String AUTHENTICATION_SELECTION = 'authenticationSelection';
  static const String DEVICE_IS_TRUSTED = 'deviceIsTrusted';

  NativeMethods._();
}

class SendServerPayloadArgs {
  static const String PAYLOAD = 'payload';

  SendServerPayloadArgs._();
}

class PairingSelectionArgs {
  static const String TRUST_LEVEL = 'trustLevel';
  static const String ACTION = 'action';
  static const String USERNAME = 'username';

  PairingSelectionArgs._();
}

class AuthenticationSelectionArgs {
  static const String ACTION = 'action';
  static const String USERNAME = 'username';

  AuthenticationSelectionArgs._();
}

class PingEvents {
  //Pairing
  static const String PAIRING_OPTIONS_REQUIRED = 'onPairingOptionsRequired';
  static const String PAIRING_OPTIONS_REQUIRED_WITH_PASSWORD =
      "onPairingOptionsRequiredWithPasscode";
  static const String PAIRING_PROGRESS = "onPairingProgress";
  static const String PAIRING_COMPLETED = "onPairingCompleted";
  static const String IGNORE_DEVICE_COMPLETED = "onIgnoreDeviceCompleted";
  static const String DID_UNTRUST_DEVICE = "didUntrustDevice";
  //Authentication
  static const String AUTHENTICATION_REQUIRED = "onAuthenticationRequired";
  static const String AUTHENTICATION_COMPLETED = "onAuthenticationCompleted";
  static const String AUTHENTICATION_CANCELLED = "onAuthenticationCancelled";
  static const String ONE_TIME_PASSWORD_CHANGED = "onOneTimePasscodeChanged";
  static const String AUTHENTICATION_TOKEN_STATUS = "authenticationTokenStatus";
  //General
  static const String SERVICE_PAYLOAD_RECEIVED_WITH_STATUS_DONE =
      "onServicePayloadReceivedWithStatusDone";
  static const String LOGS_SENT_TO_SERVER = "onLogsSentToServer";
  static const String GENERAL_MESSAGE = "onGeneralMessage";
  static const String GOOGLE_PLAY_SERVICES_STATUS_RECEIVED =
      "onGooglePlayServicesStatusReceived";
  static const String ERROR = "onError";

  PingEvents._();
}

class PairingOptionsRequiredArgs {
  static const String AVAILABLE_TRUST_LEVELS = "availableTrustLevels";
  static const String DEVICE_NAME = "deviceName";

  PairingOptionsRequiredArgs._();
}

class PairingOptionsRequiredWithPasswordArgs {
  static const String AVAILABLE_TRUST_LEVELS = "availableTrustLevels";
  static const String DEVICE_NAME = "deviceName";

  PairingOptionsRequiredWithPasswordArgs._();
}

class PairingProgressArgs {
  static const String MESSAGE = 'message';

  PairingProgressArgs._();
}

class PairingCompletedArgs {
  static const String ACTION_STATUS = 'actionStatus';
  static const String ERROR = 'error';

  PairingCompletedArgs._();
}

class IgnoreDeviceCompletedArgs {
  static const String ACTION_STATUS = 'actionStatus';
  static const String ERROR = 'error';

  IgnoreDeviceCompletedArgs._();
}

class AuthenticationRequiredArgs {
  static const String DATA = 'data';

  AuthenticationRequiredArgs._();
}

class AuthenticationCompletedArgs {
  static const String ACTION_STATUS = 'actionStatus';
  static const String ACTION = 'action';
  static const String ERROR = 'error';

  AuthenticationCompletedArgs._();
}

class OneTimePasswordChangedArgs {
  static const String OTP = 'otp';

  OneTimePasswordChangedArgs._();
}

class AuthenticationTokenStatusArgs {
  static const String DATA = 'data';
  static const String ERROR = 'error';

  AuthenticationTokenStatusArgs._();
}

class LogsSentToServerArgs {
  static const String ACTION_STATUS = 'actionStatus';
  static const String SUPPORT_ID = 'supportId';

  LogsSentToServerArgs._();
}

class GeneralMessageArgs {
  static const String MESSAGE = 'message';

  GeneralMessageArgs._();
}

class GooglePlayServicesStatusReceivedArgs {
  static const String STATUS = 'status';

  GooglePlayServicesStatusReceivedArgs._();
}

class ErrorArgs {
  static const String THROWABLE = 'throwable';
  static const String DESCRIPTION = 'description';

  ErrorArgs._();
}

//Enums
class TrustLevelValues {
  static const String PRIMARY = 'IS_PRIMARY';
  static const String TRUSTED = 'IS_TRUSTED';
  static const String IGNORE = 'IGNORE';

  TrustLevelValues._();
}

class ActionValues {
  static const String NONE = 'none';
  static const String APPROVE = 'approve';
  static const String DENY = 'deny';
  static const String BLOCK = 'block';

  ActionValues._();
}

class ActionStatusValues {
  static const String SUCCESS = 'SUCCESS';
  static const String FAILURE = 'FAILURE';
  static const String RE_PAIR_SUCCESS = 'RE_PAIR_SUCCESS';

  ActionStatusValues._();
}

class ErrorValues {
  static const String UNKNOWN = 'PIDErrorUnknown';
  static const String WITH_PAIRING = 'PIDErrorWithPairing';
  static const String APP_DISABLED = 'PIDErrorAppDisabled';
  static const String WRONG_APP_ID = 'PIDErrorWrongAppID';
  static const String TIMEOUT = 'PIDErrorTimeout';
  static const String NO_INTERNET_CONNECTION = 'PIDErrorNoInternetConnection';
  static const String WRONG_SIGNATURE = 'PIDErrorWrongSignature';
  static const String PROBLEM_WITH_PUBLIC_KEY = 'PIDErrorProblemWithPublicKey';
  static const String NETWORK_ERROR = 'PIDNetworkError';
  static const String INTERNAL_ERROR = 'PIDInternalError';
  static const String MISSING_PERMISSIONS = 'PIDMissingPermissions';
  static const String DEVICE_TOKEN_MISSING = 'PIDErrorDeviceTokenIsMissing';
  static const String EXPIRED_OR_WRONG_AUTH_TOKEN =
      'PIDErrorExpiredOrWrongAuthToken';
  static const String WRONG_APP_ID_FROM_AUTH_TOKEN =
      'PIDErrorWrongAppIDFromAuthToken';
  static const String WRONG_ACCOUNT_ID_FROM_AUTH_TOKEN =
      'PIDErrorWrongAccountIDFromAuthToken';
  static const String USER_IS_SUSPENDED = 'PIDErrorUserIsSuspended';
  static const String USERNAME_NOT_PAIRED_FOR_TOKEN =
      'PIDErrorUsernameNotPairedForToken';
  static const String AUTH_TOKEN_ALREADY_USED = 'PIDErrorAuthTokenAlreadyUsed';
  static const String SERVER_RESPONSE = 'PIDErrorServerResponse';
  static const String DEVICE_ROOTED = 'PIDErrorDeviceRooted';
  static const String WITH_REPAIRING = 'PIDErrorWithRepairing';
  static const String WITH_REPAIRING_TEST_OTP = 'PIDErrorWithRepairingTestOtp';
  //iOS Only
  static const String REACHABILITY = "PIDErrorReachability";
  static const String SERVER_INTERNAL = "PIDErrorServerInternal";
  static const String WITH_SERVER_PAYLOAD = "PIDErrorWithServerPayload";
  static const String SELECTION_IS_MISSING = "PIDErrorSelectionIsMissing";
  static const String MISSING_APP_ID = "PIDErrorMissingAppId";

  ErrorValues._();
}
