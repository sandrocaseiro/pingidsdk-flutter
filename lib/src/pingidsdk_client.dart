import 'dart:async';

import 'package:flutter/services.dart';

import 'constants.dart';
import 'extensions/extensions.dart';
import 'models/authentication_completed.dart';
import 'models/ignore_device_completed.dart';
import 'models/logs_sent_server.dart';
import 'models/pairing_options_required.dart';
import 'models/pairing_completed.dart';
import 'models/enums/trust_level.dart';
import 'models/enums/action.dart';

class PingIDSDKClient {
  final MethodChannel _channel = const MethodChannel('pingidsdk');
  StreamController<PairingOptionsRequired> _pairingOptionsRequiredController;
  StreamController<PairingOptionsRequired>
      _pairingOptionsRequiredWithPasswordController;
  StreamController<String> _pairingProgressController;
  StreamController<PairingCompleted> _pairingCompletedController;
  StreamController<IgnoreDeviceCompleted> _ignoreDeviceCompletedController;
  StreamController<void> _didUntrustDeviceCompletedController;
  StreamController<dynamic> _authenticationRequiredController;
  StreamController<AuthenticationCompleted> _authenticationCompletedController;
  StreamController<void> _authenticationCancelledController;
  StreamController<String> _oneTimePasswordChangedController;
  StreamController<dynamic> _authenticationTokenStatusController;
  StreamController<void> _servicePayloadReceivedWithStatusDoneController;
  StreamController<LogsSentToServer> _logsSentToServerController;
  StreamController<String> _generalMessageController;
  StreamController<int> _googlePlayServicesStatusReceivedController;
  StreamController<dynamic> _errorController;

  PingIDSDKClient() {
    _pairingOptionsRequiredController =
        StreamController<PairingOptionsRequired>.broadcast();
    _pairingOptionsRequiredWithPasswordController =
        StreamController<PairingOptionsRequired>.broadcast();
    _pairingProgressController = StreamController<String>.broadcast();
    _pairingCompletedController =
        StreamController<PairingCompleted>.broadcast();
    _ignoreDeviceCompletedController =
        StreamController<IgnoreDeviceCompleted>.broadcast();
    _didUntrustDeviceCompletedController = StreamController<void>.broadcast();
    _authenticationRequiredController = StreamController<dynamic>.broadcast();
    _authenticationCompletedController =
        StreamController<AuthenticationCompleted>.broadcast();
    _authenticationCancelledController = StreamController<void>.broadcast();
    _oneTimePasswordChangedController = StreamController<String>.broadcast();
    _authenticationTokenStatusController =
        StreamController<dynamic>.broadcast();
    _servicePayloadReceivedWithStatusDoneController =
        StreamController<void>.broadcast();
    _logsSentToServerController =
        StreamController<LogsSentToServer>.broadcast();
    _generalMessageController = StreamController<String>.broadcast();
    _googlePlayServicesStatusReceivedController =
        StreamController<int>.broadcast();
    _errorController = StreamController<dynamic>.broadcast();
    _channel.setMethodCallHandler(_callbacks);
  }

  Future<dynamic> _callbacks(MethodCall call) {
    print(call.method);
    print(call.arguments);
    try {
      switch (call.method) {
        case PingEvents.PAIRING_OPTIONS_REQUIRED:
          _pairingOptionsRequiredController
              .add(call.parsePairingOptionsRequired());
          break;
        case PingEvents.PAIRING_OPTIONS_REQUIRED_WITH_PASSWORD:
          _pairingOptionsRequiredWithPasswordController
              .add(call.parsePairingOptionsRequiredWithPassword());
          break;
        case PingEvents.PAIRING_PROGRESS:
          _pairingProgressController.add(call.parsePairingProgress());
          break;
        case PingEvents.PAIRING_COMPLETED:
          _pairingCompletedController.add(call.parsePairingCompleted());
          break;
        case PingEvents.IGNORE_DEVICE_COMPLETED:
          _ignoreDeviceCompletedController
              .add(call.parseIgnoreDeviceCompleted());
          break;
        case PingEvents.DID_UNTRUST_DEVICE:
          _didUntrustDeviceCompletedController.add(null);
          break;
        case PingEvents.AUTHENTICATION_REQUIRED:
          _authenticationRequiredController
              .add(call.parseAuthenticationRequired());
          break;
        case PingEvents.AUTHENTICATION_COMPLETED:
          _authenticationCompletedController
              .add(call.parseAuthenticationCompleted());
          break;
        case PingEvents.AUTHENTICATION_CANCELLED:
          _authenticationCancelledController.add(null);
          break;
        case PingEvents.ONE_TIME_PASSWORD_CHANGED:
          _oneTimePasswordChangedController
              .add(call.parseOneTimePasswordChanged());
          break;
        case PingEvents.AUTHENTICATION_TOKEN_STATUS:
          _authenticationTokenStatusController
              .add(call.parseAuthenticationTokenStatus());
          break;
        case PingEvents.SERVICE_PAYLOAD_RECEIVED_WITH_STATUS_DONE:
          _servicePayloadReceivedWithStatusDoneController.add(null);
          break;
        case PingEvents.LOGS_SENT_TO_SERVER:
          _logsSentToServerController.add(call.parseLogsSentToServer());
          break;
        case PingEvents.GENERAL_MESSAGE:
          _generalMessageController.add(call.parseGeneralMessage());
          break;
        case PingEvents.GOOGLE_PLAY_SERVICES_STATUS_RECEIVED:
          _googlePlayServicesStatusReceivedController
              .add(call.parseGooglePlayServicesStatusReceived());
          break;
        case PingEvents.ERROR:
          _errorController.add(call.parseError());
          break;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<String> get payload =>
      _channel.invokeMethod(NativeMethods.GET_PAYLOAD);

  Future<void> sendServerPayload(String payload) =>
      _channel.invokeMethod(NativeMethods.SEND_SERVER_PAYLOAD, {
        SendServerPayloadArgs.PAYLOAD: payload,
      });

  Future<void> pairingSelection(
          TrustLevel trustLevel, Action action, String username) =>
      _channel.invokeMethod(NativeMethods.PAIRING_SELECTION, {
        PairingSelectionArgs.TRUST_LEVEL: trustLevel.value,
        PairingSelectionArgs.ACTION: action.value,
        PairingSelectionArgs.USERNAME: username
      });

  Future<void> authenticationSelection(Action action, String username) =>
      _channel.invokeMethod(NativeMethods.AUTHENTICATION_SELECTION, {
        AuthenticationSelectionArgs.ACTION: action.value,
        AuthenticationSelectionArgs.USERNAME: username
      });

  Future<bool> get deviceIsTrusted =>
      _channel.invokeMethod(NativeMethods.DEVICE_IS_TRUSTED);

  Stream<PairingOptionsRequired> get pairingOptionsRequired =>
      _pairingOptionsRequiredController.stream;
  Stream<PairingOptionsRequired> get pairingOptionsRequiredWithPassword =>
      _pairingOptionsRequiredWithPasswordController.stream;
  Stream<String> get pairingProgress => _pairingProgressController.stream;
  Stream<PairingCompleted> get pairingCompleted =>
      _pairingCompletedController.stream;
  Stream<IgnoreDeviceCompleted> get ignoreDeviceCompleted =>
      _ignoreDeviceCompletedController.stream;
  Stream<void> get didUntrustDevice =>
      _didUntrustDeviceCompletedController.stream;
  Stream<dynamic> get authenticationRequired =>
      _authenticationRequiredController.stream;
  Stream<AuthenticationCompleted> get authenticationCompleted =>
      _authenticationCompletedController.stream;
  Stream<void> get authenticationCancelled =>
      _authenticationCancelledController.stream;
  Stream<String> get oneTimePasswordChanged =>
      _oneTimePasswordChangedController.stream;
  Stream<dynamic> get authenticationTokenStatus =>
      _authenticationTokenStatusController.stream;
  Stream<void> get servicePayloadReceivedWithStatusDone =>
      _servicePayloadReceivedWithStatusDoneController.stream;
  Stream<LogsSentToServer> get logsSentToServer =>
      _logsSentToServerController.stream;
  Stream<String> get generalMessage => _generalMessageController.stream;
  Stream<int> get googlePlayServicesStatusReceived =>
      _googlePlayServicesStatusReceivedController.stream;
  Stream<dynamic> get error => _errorController.stream;
}
