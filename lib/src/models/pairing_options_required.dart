import 'package:pingidsdk/src/models/enums/trust_level.dart';

class PairingOptionsRequired {
  final List<TrustLevel> _availableTrustLevels;
  final String deviceName;

  PairingOptionsRequired(this._availableTrustLevels, [this.deviceName]);

  List<TrustLevel> get availableTrustLevels => [..._availableTrustLevels];
}
