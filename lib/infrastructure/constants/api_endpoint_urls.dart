abstract class EndpointUrls {
  /// public
  static const String mobileAppSettings = "/api/public/mobile_settings";
  static const String getFaqs = "/api/public/faqs";
  static const String getTermsAndConditions = "/api/public/terms";
  static const String getPrivacyPolicies = "/api/public/policies";
  static const String sendContactUs = "/api/public/contactus";

  /// Auth
  static const String individualSignup = "/api/auth/signup";
  static const String phoneLogin = "/api/auth/login";
  static const String refreshTokens = "/api/auth/refresh";
  static const String logout = "/api/auth/logout";
  // password forgot
  static const String forgotPasswordPhonePinRequest = "/api/UserAccount/ForgotPasswordForMobile";
  static const String forgotPasswordPhoneReset = "/api/UserAccount/ResetPasswordForMobile";
  // password change
  static const String changePasswordPhonePinRequest = "/api/UserAccount/ChangePassword";
  // profile
  static const String getCurrentProfile = "/api/profiles/current_profile";
  static const String editProfileById = "/api/profiles/:profile_id";
  // account
  static const String getAccountProfiles = "/api/profiles";
  static const String switchProfile = "/api/auth/switch_profile";
  static const String updatePassword = "/api/auth/update_password";
  static const String deleteAccount = "/api/auth/delete_user";

  //auctions categories
  static const String getAucMainCategories = "/api/categories";
  //auctions
  static const String getAuctions = "/api/auctions";
}
