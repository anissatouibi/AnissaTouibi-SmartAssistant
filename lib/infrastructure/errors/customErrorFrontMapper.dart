import 'package:smart_assistant_app/i18n/strings.g.dart';

enum DucumentedError {
  unknown,
  pendingProfile,
  incorrectSignInCredentials,
  pwLongerThan1Char,
  weakPw,
  invalidEmail,
  pwAndConfirmPwDontMatch,
  phoneAlreadyExist,
  newPasswordMatchesOldPassword,
  emailAlreadyExist,
  phoneNumberDoesntExist,
  serverError,
  accessUnauthorized,
  incorrectPassword,
  invalidPhoneNumber,
  newBidLowerThanHighest,
  cannotParticipateInAuction,
  accountDoesNotExist,
  profileAlreadyAffiliated,
  cannotAddThisUser,
  bidIsLowerThanMinBid,
  cannotParticipateincompleteOrBanned,
}

class CustomErrorFrontMapper {
  static DucumentedError errorCodeToDucumentedError(String errorCode) {
    final statusCode = errorCode.split(".")[0];
    final nestedErrorCode = errorCode.split(".")[1];
    late DucumentedError ducumentedError;
    switch (statusCode) {
      case "400":
        switch (nestedErrorCode) {
          case "02200":
            ducumentedError = DucumentedError.pwLongerThan1Char;
            break;
          case "03507":
            ducumentedError = DucumentedError.weakPw;
            break;
          case "35830":
            ducumentedError = DucumentedError.invalidEmail;
            break;
          case "36766":
            ducumentedError = DucumentedError.pwAndConfirmPwDontMatch;
            break;
          case "58261":
            ducumentedError = DucumentedError.pwLongerThan1Char;
            break;
          case "49546":
            ducumentedError = DucumentedError.invalidPhoneNumber;
            break;
          case "14516":
            ducumentedError = DucumentedError.newBidLowerThanHighest;
            break;
          case "28754":
            ducumentedError = DucumentedError.cannotAddThisUser;
            break;
          case "40443":
            ducumentedError = DucumentedError.bidIsLowerThanMinBid;
            break;
          default:
            ducumentedError = DucumentedError.unknown;
            break;
        }
        break;
      case "401":
        switch (nestedErrorCode) {
          case "04480":
            ducumentedError = DucumentedError.incorrectSignInCredentials;
            break;
          case "04956":
            ducumentedError = DucumentedError.incorrectPassword;
            break;
          case "18695":
            ducumentedError = DucumentedError.accessUnauthorized;
            break;
          default:
            ducumentedError = DucumentedError.unknown;
            break;
        }
        break;
      case "403":
        switch (nestedErrorCode) {
          case "20163":
            ducumentedError = DucumentedError.pendingProfile;
            break;
          case "09777":
            ducumentedError = DucumentedError.cannotParticipateInAuction;
            break;
          default:
            ducumentedError = DucumentedError.unknown;
            break;
        }
        break;
      case "404":
        switch (nestedErrorCode) {
          case "55773":
            ducumentedError = DucumentedError.phoneNumberDoesntExist;
            break;
          case "37746":
            ducumentedError = DucumentedError.phoneNumberDoesntExist;
            break;
          case "60846":
            ducumentedError = DucumentedError.accountDoesNotExist;
            break;
          case "29731":
            ducumentedError = DucumentedError.cannotParticipateincompleteOrBanned;
            break;
          default:
            ducumentedError = DucumentedError.unknown;
            break;
        }
        break;
      case "409":
        switch (nestedErrorCode) {
          case "03060":
            ducumentedError = DucumentedError.phoneAlreadyExist;
            break;
          case "22241":
            ducumentedError = DucumentedError.newPasswordMatchesOldPassword;
            break;
          case "48610":
            ducumentedError = DucumentedError.emailAlreadyExist;
            break;
          case "61801":
            ducumentedError = DucumentedError.profileAlreadyAffiliated;
            break;
          case "11760":
            ducumentedError = DucumentedError.profileAlreadyAffiliated;
            break;
          default:
            ducumentedError = DucumentedError.unknown;
            break;
        }
        break;
      case "500":
        switch (nestedErrorCode) {
          case "62837":
          case "49322":
            ducumentedError = DucumentedError.serverError;
            break;
          default:
            ducumentedError = DucumentedError.unknown;
        }
    }
    return ducumentedError;
  }

  static String getCustomBackendMappedTranslatedMessage(Map error) {
    switch (errorCodeToDucumentedError(error['errorCode'])) {
      case DucumentedError.unknown:
        return t.errors.failures.undocumentedError;
      case DucumentedError.pendingProfile:
        return t.errors.failures.documented.pendingProfile;
      case DucumentedError.incorrectSignInCredentials:
        return t.errors.failures.documented.incorrectSignInCredentials;
      case DucumentedError.pwLongerThan1Char:
        return t.errors.failures.documented.pwLongerThan1Char;
      case DucumentedError.weakPw:
        return t.errors.failures.documented.weakPw;
      case DucumentedError.invalidEmail:
        return t.errors.failures.documented.invalidEmail;
      case DucumentedError.pwAndConfirmPwDontMatch:
        return t.errors.failures.documented.pwAndConfirmPwDontMatch;
      case DucumentedError.phoneNumberDoesntExist:
        return t.errors.failures.documented.phoneDoesntExist;
      case DucumentedError.phoneAlreadyExist:
        return t.errors.failures.documented.phoneAlreadyExist;
      case DucumentedError.newPasswordMatchesOldPassword:
        return t.errors.failures.documented.newPasswordMatchesOldPassword;
      case DucumentedError.emailAlreadyExist:
        return t.errors.failures.documented.emailAlreadyExist;
      case DucumentedError.newBidLowerThanHighest:
        return t.errors.failures.documented.newBidLowerThanHighest;
      case DucumentedError.cannotParticipateInAuction:
        return t.errors.failures.documented.cannotParticipateInAuction;
      case DucumentedError.accountDoesNotExist:
        return t.errors.failures.documented.accountDoesNotExist;
      case DucumentedError.profileAlreadyAffiliated:
        return t.errors.failures.documented.profileAlreadyAffiliated;
      case DucumentedError.serverError:
        return t.errors.failures.documented.serverError;
      case DucumentedError.accessUnauthorized:
        return t.errors.failures.documented.accessUnauthorized;

      case DucumentedError.incorrectPassword:
        return t.errors.failures.documented.incorrectPassword;

      case DucumentedError.invalidPhoneNumber:
        return t.errors.failures.documented.invalidPhoneNumber;
      case DucumentedError.cannotAddThisUser:
        return t.errors.failures.documented.cannotAddThisUser;
      case DucumentedError.bidIsLowerThanMinBid:
        return t.errors.failures.documented.bidIsLowerThanMinBid;
      case DucumentedError.cannotParticipateincompleteOrBanned:
        return t.errors.failures.documented.cannotParticipateincompleteOrBanned;
      default:
        return t.errors.failures.undocumentedError;
    }
  }
}
