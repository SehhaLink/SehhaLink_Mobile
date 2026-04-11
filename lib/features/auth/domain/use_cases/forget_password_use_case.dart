
import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/auth/domain/repo/auth_repo.dart';

class ForgetPasswordUseCase {
  final AuthRepo authRepo;

  ForgetPasswordUseCase({required this.authRepo});
  Future<ApiResult<void>> call(String email) async {
    return authRepo.forgetPassword(email);
  }
}
