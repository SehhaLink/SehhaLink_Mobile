import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/auth/domain/repo/auth_repo.dart';
import 'package:sehhalink/features/auth/data/model/login_request_body.dart';

class LoginUseCase {
  final AuthRepo authRepo;

  LoginUseCase({required this.authRepo});

  Future<ApiResult<void>> call(LoginRequestBody loginRequest) async {
    return await authRepo.login(loginRequest);
  }
}