import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/auth/register/data/models/register_request_body.dart';

abstract class RegisterRepo {
  Future<ApiResult<void>>register(RegisterRequestBody registerRequestBody);
}