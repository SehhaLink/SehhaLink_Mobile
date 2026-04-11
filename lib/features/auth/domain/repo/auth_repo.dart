import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/auth/data/model/reset_password_model.dart';
import 'package:sehhalink/features/auth/data/model/login_request_body.dart';
import 'package:sehhalink/features/auth/data/model/register_request_body.dart';

abstract class AuthRepo {
  Future<ApiResult<void>> register(RegisterRequestBody registerRequestBody);
  Future<ApiResult<bool>> forgetPassword(String email);
  Future<ApiResult<bool>> resetPassword(ResetPasswordModel resetmodel);
  Future<ApiResult<void>> login(LoginRequestBody loginRequest);
}
