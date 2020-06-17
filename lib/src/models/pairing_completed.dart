import 'enums/action_status.dart';
import 'enums/error.dart';

class PairingCompleted {
  final ActionStatus actionStatus;
  final Error error;

  PairingCompleted(this.actionStatus, this.error);
}
