import 'enums/action_status.dart';
import 'enums/action.dart';
import 'enums/error.dart';

class AuthenticationCompleted {
  final ActionStatus actionStatus;
  final Action action;
  final Error error;

  AuthenticationCompleted({this.actionStatus, this.action, this.error});
}
