import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/auth/domain/repo/auth_repo.dart';
import 'package:sehhalink/features/auth/data/model/register_request_body.dart';

class RegisterUseCase {
  final AuthRepo authRepo;
  RegisterUseCase(this.authRepo);

  Future<ApiResult<void>> register(RegisterRequestBody body) {
    return authRepo.register(body);
  }
}
