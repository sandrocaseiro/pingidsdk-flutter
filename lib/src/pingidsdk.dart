import 'dart:async';

import 'pingidsdk_client.dart';
import 'models/authentication_completed.dart';
import 'models/ignore_device_completed.dart';
import 'models/logs_sent_server.dart';
import 'models/pairing_options_required.dart';
import 'models/pairing_completed.dart';
import 'models/enums/action.dart';
import 'models/enums/trust_level.dart';

class PingIDSDK {
  final PingIDSDKClient _client;
  static PingIDSDK _instance = PingIDSDK._(PingIDSDKClient());

  PingIDSDK._(this._client);

  static PingIDSDK get instance => _instance;

  //Native Methods
  Future<String> get payload => _client.payload;
  Future<void> sendServerPayload(String payload) =>
      _client.sendServerPayload(payload);
  Future<void> pairingSelection(String username,
          [TrustLevel trustLevel = TrustLevel.IGNORE,
          Action action = Action.NONE]) =>
      _client.pairingSelection(trustLevel, action, username);
  Future<void> authenticationSelection(String username,
          [Action action = Action.NONE]) =>
      _client.authenticationSelection(action, username);
  Future<bool> get deviceIsTrusted => _client.deviceIsTrusted;

  //Events
  Stream<PairingOptionsRequired> get pairingOptionsRequired =>
      _client.pairingOptionsRequired;
  Stream<PairingOptionsRequired> get pairingOptionsRequiredWithPassword =>
      _client.pairingOptionsRequiredWithPassword;
  Stream<String> get pairingProgress => _client.pairingProgress;
  Stream<PairingCompleted> get pairingCompleted => _client.pairingCompleted;
  Stream<IgnoreDeviceCompleted> get ignoreDeviceCompleted =>
      _client.ignoreDeviceCompleted;
  Stream<void> get didUntrustDevice => _client.didUntrustDevice;
  Stream<dynamic> get authenticationRequired => _client.authenticationRequired;
  Stream<AuthenticationCompleted> get authenticationCompleted =>
      _client.authenticationCompleted;
  Stream<void> get authenticationCancelled => _client.authenticationCancelled;
  Stream<String> get oneTimePasswordChanged => _client.oneTimePasswordChanged;
  Stream<dynamic> get authenticationTokenStatus =>
      _client.authenticationTokenStatus;
  Stream<void> get servicePayloadReceivedWithStatusDone =>
      _client.servicePayloadReceivedWithStatusDone;
  Stream<LogsSentToServer> get logsSentToServer => _client.logsSentToServer;
  Stream<String> get generalMessage => _client.generalMessage;
  Stream<int> get googlePlayServicesStatusReceived =>
      _client.googlePlayServicesStatusReceived;
  Stream<dynamic> get error => _client.error;
}
