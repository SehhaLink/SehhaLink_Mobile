class ApiConst {
  static const String baseurl = 'https://backend-sehhalink.up.railway.app/api';
  static const String register = '/Auth/register';
  static const String login = '/Auth/Login';
  static const String forgetPassword = "/Account/forget-password";
  static const String resetPassword = "/Account/reset-password";
  static const String profile = '/User/me';
  static const String changeProfilePATCH = '/User/me';
  static const String deactivateAccount = '/User/deactivate';
  static const String deleteAccountDELETE = '/User/me';
  static const String historySummary = "/Documents/history-summary";
  static const String uploadDocument = "/Documents/upload";
  static String summarize(int fileId) => '/Documents/$fileId/summarize';
  static const String updateProfileImage = "/User/Upload-image";
}
