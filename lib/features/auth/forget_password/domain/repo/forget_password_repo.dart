
import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/auth/forget_password/data/models/reset_password_model.dart';

abstract class ForgetPasswordRepo {
  Future<ApiResult<bool>> forgetPassword(String email);
  Future<ApiResult<bool>> resetPassword(ResetPasswordModel resetmodel);
}
