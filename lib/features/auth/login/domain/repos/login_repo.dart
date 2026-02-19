
import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/auth/login/data/models/login_request_body.dart';

abstract class LoginRepo {
  Future<ApiResult<void>> login(LoginRequestBody loginRequest);
}
