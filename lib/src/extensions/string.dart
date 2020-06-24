import 'package:pingidsdk/src/constants.dart';

import '../models/enums/trust_level.dart';
import '../models/enums/action.dart';
import '../models/enums/action_status.dart';
import '../models/enums/error.dart';

extension EnumParsing on String {
  TrustLevel parseTrustLevel() {
    switch (this) {
      case TrustLevelValues.PRIMARY:
        return TrustLevel.PRIMARY;
      case TrustLevelValues.TRUSTED:
        return TrustLevel.TRUSTED;
      case TrustLevelValues.IGNORE:
      default:
        return TrustLevel.IGNORE;
    }
  }

  Action parseAction() {
    switch (this) {
      case ActionValues.APPROVE:
        return Action.APPROVE;
      case ActionValues.BLOCK:
        return Action.BLOCK;
      case ActionValues.DENY:
        return Action.DENY;
      case ActionValues.NONE:
      default:
        return Action.NONE;
    }
  }

  ActionStatus parseActionStatus() {
    switch (this) {
      case ActionStatusValues.SUCCESS:
        return ActionStatus.SUCCESS;
      case ActionStatusValues.RE_PAIR_SUCCESS:
        return ActionStatus.RE_PAIR_SUCCESS;
      case ActionStatusValues.FAILURE:
      default:
        return ActionStatus.FAILURE;
    }
  }

  Error parseError() {
    switch (this) {
      case ErrorValues.WITH_PAIRING:
        return Error.WITH_PAIRING;
      case ErrorValues.APP_DISABLED:
        return Error.APP_DISABLED;
      case ErrorValues.WRONG_APP_ID:
        return Error.WRONG_APP_ID;
      case ErrorValues.TIMEOUT:
        return Error.TIMEOUT;
      case ErrorValues.NO_INTERNET_CONNECTION:
        return Error.NO_INTERNET_CONNECTION;
      case ErrorValues.WRONG_SIGNATURE:
        return Error.WRONG_SIGNATURE;
      case ErrorValues.PROBLEM_WITH_PUBLIC_KEY:
        return Error.PROBLEM_WITH_PUBLIC_KEY;
      case ErrorValues.NETWORK_ERROR:
        return Error.NETWORK_ERROR;
      case ErrorValues.INTERNAL_ERROR:
        return Error.INTERNAL_ERROR;
      case ErrorValues.MISSING_PERMISSIONS:
        return Error.MISSING_PERMISSIONS;
      case ErrorValues.DEVICE_TOKEN_MISSING:
        return Error.DEVICE_TOKEN_MISSING;
      case ErrorValues.EXPIRED_OR_WRONG_AUTH_TOKEN:
        return Error.EXPIRED_OR_WRONG_AUTH_TOKEN;
      case ErrorValues.WRONG_APP_ID_FROM_AUTH_TOKEN:
        return Error.WRONG_APP_ID_FROM_AUTH_TOKEN;
      case ErrorValues.WRONG_ACCOUNT_ID_FROM_AUTH_TOKEN:
        return Error.WRONG_ACCOUNT_ID_FROM_AUTH_TOKEN;
      case ErrorValues.USER_IS_SUSPENDED:
        return Error.USER_IS_SUSPENDED;
      case ErrorValues.USERNAME_NOT_PAIRED_FOR_TOKEN:
        return Error.USERNAME_NOT_PAIRED_FOR_TOKEN;
      case ErrorValues.AUTH_TOKEN_ALREADY_USED:
        return Error.AUTH_TOKEN_ALREADY_USED;
      case ErrorValues.SERVER_RESPONSE:
        return Error.SERVER_RESPONSE;
      case ErrorValues.DEVICE_ROOTED:
        return Error.DEVICE_ROOTED;
      case ErrorValues.WITH_REPAIRING:
        return Error.WITH_REPAIRING;
      case ErrorValues.WITH_REPAIRING_TEST_OTP:
        return Error.WITH_REPAIRING_TEST_OTP;
      case ErrorValues.REACHABILITY:
        return Error.REACHABILITY;
      case ErrorValues.SERVER_INTERNAL:
        return Error.SERVER_INTERNAL;
      case ErrorValues.WITH_SERVER_PAYLOAD:
        return Error.WITH_SERVER_PAYLOAD;
      case ErrorValues.SELECTION_IS_MISSING:
        return Error.SELECTION_IS_MISSING;
      case ErrorValues.MISSING_APP_ID:
        return Error.MISSING_APP_ID;
      case ErrorValues.UNKNOWN:
      default:
        return Error.UNKNOWN;
    }
  }
}
