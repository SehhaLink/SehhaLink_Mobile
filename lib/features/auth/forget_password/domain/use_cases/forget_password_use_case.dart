
import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/auth/forget_password/domain/repo/forget_password_repo.dart';

class ForgetPasswordUseCase {
  final ForgetPasswordRepo forgetPasswordRepo;

  ForgetPasswordUseCase({required this.forgetPasswordRepo});
  Future<ApiResult<void>> call(String email) async {
    return forgetPasswordRepo.forgetPassword(email);
  }
}
