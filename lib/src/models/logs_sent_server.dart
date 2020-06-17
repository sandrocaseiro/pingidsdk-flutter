import 'enums/action_status.dart';

class LogsSentToServer {
  final ActionStatus actionStatus;
  final String supportId;

  LogsSentToServer(this.actionStatus, this.supportId);
}
