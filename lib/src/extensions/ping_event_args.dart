import 'package:flutter/services.dart';

import '../constants.dart';
import 'extensions.dart';
import '../models/authentication_completed.dart';
import '../models/ignore_device_completed.dart';
import '../models/logs_sent_server.dart';
import '../models/pairing_options_required.dart';
import '../models/pairing_completed.dart';

extension PingEventArgsParsing on MethodCall {
  PairingOptionsRequired parsePairingOptionsRequired() {
    final args = this.arguments;
    final trustLevelsArg =
        args[PairingOptionsRequiredArgs.AVAILABLE_TRUST_LEVELS] as List;

    final deviceName = args[PairingOptionsRequiredArgs.DEVICE_NAME];
    final trustLevels =
        trustLevelsArg?.map((t) => t.toString().parseTrustLevel())?.toList() ??
            [];

    return PairingOptionsRequired(trustLevels, deviceName);
  }

  PairingOptionsRequired parsePairingOptionsRequiredWithPassword() {
    final args = this.arguments;
    final trustLevelsArg =
        args[PairingOptionsRequiredWithPasswordArgs.AVAILABLE_TRUST_LEVELS]
            as List;

    final deviceName = args[PairingOptionsRequiredWithPasswordArgs.DEVICE_NAME];
    final trustLevels =
        trustLevelsArg?.map((t) => t.toString().parseTrustLevel())?.toList() ??
            [];

    return PairingOptionsRequired(trustLevels, deviceName);
  }

  String parsePairingProgress() => this.arguments[PairingProgressArgs.MESSAGE];

  PairingCompleted parsePairingCompleted() {
    final args = this.arguments;
    final actionStatus =
        args[PairingCompletedArgs.ACTION_STATUS].toString().parseActionStatus();
    final error = args[PairingCompletedArgs.ERROR]?.toString()?.parseError();

    return PairingCompleted(actionStatus, error);
  }

  IgnoreDeviceCompleted parseIgnoreDeviceCompleted() {
    final args = this.arguments;
    final actionStatus = args[IgnoreDeviceCompletedArgs.ACTION_STATUS]
        .toString()
        .parseActionStatus();
    final error = args[IgnoreDeviceCompletedArgs.ERROR].toString().parseError();

    return IgnoreDeviceCompleted(actionStatus, error);
  }

  dynamic parseAuthenticationRequired() {
    final data = this.arguments[AuthenticationRequiredArgs.DATA];

    return data;
  }

  AuthenticationCompleted parseAuthenticationCompleted() {
    final args = this.arguments;
    final actionStatus = args[AuthenticationCompletedArgs.ACTION_STATUS]
        .toString()
        .parseActionStatus();
    final action =
        args[AuthenticationCompletedArgs.ACTION].toString().parseAction();
    final error =
        args[AuthenticationCompletedArgs.ERROR].toString().parseError();

    return AuthenticationCompleted(
        actionStatus: actionStatus, action: action, error: error);
  }

  String parseOneTimePasswordChanged() =>
      this.arguments[OneTimePasswordChangedArgs.OTP];

  dynamic parseAuthenticationTokenStatus() {
    final args = this.arguments;
    final data = args[AuthenticationTokenStatusArgs.DATA];
    final error =
        args[AuthenticationTokenStatusArgs.ERROR].toString().parseError();

    return {data, error};
  }

  LogsSentToServer parseLogsSentToServer() {
    final args = this.arguments;
    final actionStatus =
        args[LogsSentToServerArgs.ACTION_STATUS].toString().parseActionStatus();
    final supportId = args[LogsSentToServerArgs.SUPPORT_ID];

    return LogsSentToServer(actionStatus, supportId);
  }

  String parseGeneralMessage() => this.arguments[GeneralMessageArgs.MESSAGE];

  int parseGooglePlayServicesStatusReceived() =>
      this.arguments[GooglePlayServicesStatusReceivedArgs.STATUS];

  dynamic parseError() {
    final args = this.arguments;
    final throwable = args[ErrorArgs.THROWABLE];
    final description = args[ErrorArgs.DESCRIPTION];

    return {throwable, description};
  }
}
