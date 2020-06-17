import 'enums/action_status.dart';
import 'enums/error.dart';

class IgnoreDeviceCompleted {
  final ActionStatus actionStatus;
  final Error error;

  IgnoreDeviceCompleted(this.actionStatus, this.error);
}
