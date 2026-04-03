class ApiConst {
  static const String baseurl = 'https://backend-sehhalink.up.railway.app/api';
  static const String register = '/Auth/register';
  static const String login = '/Auth/Login';
  static const String forgetPassword = "/Account/forget-password";
  static const String resetPassword = "/Account/reset-password";
  static String profile = '/User/me';
  static String changeProfilePATCH = '/User/me';
  static String deactivateAccount = '/User/deactivate';
  static String deleteAccountDELETE = '/User/me';
  static String historySummary = "/Documents/history-summary";
  static const String uploadDocument = "/Documents/upload";
  static String summarize(int fileId) => '/Documents/27/summarize';
}
