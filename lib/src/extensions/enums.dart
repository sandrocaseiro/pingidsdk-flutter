import 'package:pingidsdk/src/constants.dart';

import '../models/enums/trust_level.dart';
import '../models/enums/action.dart';
import '../models/enums/action_status.dart';
import '../models/enums/error.dart';

extension TrustLevelNativeParsing on TrustLevel {
  String get value {
    switch (this) {
      case TrustLevel.PRIMARY:
        return TrustLevelValues.PRIMARY;
      case TrustLevel.TRUSTED:
        return TrustLevelValues.TRUSTED;
      case TrustLevel.IGNORE:
      default:
        return TrustLevelValues.IGNORE;
    }
  }
}

extension ActionNativeParsing on Action {
  String get value {
    switch (this) {
      case Action.APPROVE:
        return ActionValues.APPROVE;
      case Action.DENY:
        return ActionValues.DENY;
      case Action.BLOCK:
        return ActionValues.BLOCK;
      case Action.NONE:
      default:
        return ActionValues.NONE;
    }
  }
}

extension ActionStatusNativeParsing on ActionStatus {
  String get value {
    switch (this) {
      case ActionStatus.SUCCESS:
        return ActionStatusValues.SUCCESS;
      case ActionStatus.RE_PAIR_SUCCESS:
        return ActionStatusValues.RE_PAIR_SUCCESS;
      case ActionStatus.FAILURE:
      default:
        return ActionStatusValues.FAILURE;
    }
  }
}

extension ErrorNativeParsing on Error {
  String get value {
    switch (this) {
      case Error.WITH_PAIRING:
        return ErrorValues.WITH_PAIRING;
      case Error.APP_DISABLED:
        return ErrorValues.APP_DISABLED;
      case Error.WRONG_APP_ID:
        return ErrorValues.WRONG_APP_ID;
      case Error.TIMEOUT:
        return ErrorValues.TIMEOUT;
      case Error.NO_INTERNET_CONNECTION:
        return ErrorValues.NO_INTERNET_CONNECTION;
      case Error.WRONG_SIGNATURE:
        return ErrorValues.WRONG_SIGNATURE;
      case Error.PROBLEM_WITH_PUBLIC_KEY:
        return ErrorValues.PROBLEM_WITH_PUBLIC_KEY;
      case Error.NETWORK_ERROR:
        return ErrorValues.NETWORK_ERROR;
      case Error.INTERNAL_ERROR:
        return ErrorValues.INTERNAL_ERROR;
      case Error.MISSING_PERMISSIONS:
        return ErrorValues.MISSING_PERMISSIONS;
      case Error.DEVICE_TOKEN_MISSING:
        return ErrorValues.DEVICE_TOKEN_MISSING;
      case Error.EXPIRED_OR_WRONG_AUTH_TOKEN:
        return ErrorValues.EXPIRED_OR_WRONG_AUTH_TOKEN;
      case Error.WRONG_APP_ID_FROM_AUTH_TOKEN:
        return ErrorValues.WRONG_APP_ID_FROM_AUTH_TOKEN;
      case Error.WRONG_ACCOUNT_ID_FROM_AUTH_TOKEN:
        return ErrorValues.WRONG_ACCOUNT_ID_FROM_AUTH_TOKEN;
      case Error.USER_IS_SUSPENDED:
        return ErrorValues.USER_IS_SUSPENDED;
      case Error.USERNAME_NOT_PAIRED_FOR_TOKEN:
        return ErrorValues.USERNAME_NOT_PAIRED_FOR_TOKEN;
      case Error.AUTH_TOKEN_ALREADY_USED:
        return ErrorValues.AUTH_TOKEN_ALREADY_USED;
      case Error.SERVER_RESPONSE:
        return ErrorValues.SERVER_RESPONSE;
      case Error.DEVICE_ROOTED:
        return ErrorValues.DEVICE_ROOTED;
      case Error.WITH_REPAIRING:
        return ErrorValues.WITH_REPAIRING;
      case Error.WITH_REPAIRING_TEST_OTP:
        return ErrorValues.WITH_REPAIRING_TEST_OTP;
      case Error.REACHABILITY:
        return ErrorValues.REACHABILITY;
      case Error.SERVER_INTERNAL:
        return ErrorValues.SERVER_INTERNAL;
      case Error.WITH_SERVER_PAYLOAD:
        return ErrorValues.WITH_SERVER_PAYLOAD;
      case Error.SELECTION_IS_MISSING:
        return ErrorValues.SELECTION_IS_MISSING;
      case Error.MISSING_APP_ID:
        return ErrorValues.MISSING_APP_ID;
      case Error.UNKNOWN:
      default:
        return ErrorValues.UNKNOWN;
    }
  }
}
