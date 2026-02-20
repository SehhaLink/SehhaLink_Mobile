import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/auth/forget_password/data/models/reset_password_model.dart';
import 'package:sehhalink/features/auth/forget_password/domain/repo/forget_password_repo.dart';

class ResetPasswordUseCase {
  final ForgetPasswordRepo forgetPasswordRepo;

  ResetPasswordUseCase({required this.forgetPasswordRepo});
  Future<ApiResult<void>> call(ResetPasswordModel resetPasswordModel) async {
    return forgetPasswordRepo.resetPassword(resetPasswordModel);
  }
}
