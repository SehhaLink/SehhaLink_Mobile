import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/auth/domain/repo/auth_repo.dart';
import 'package:sehhalink/features/auth/data/model/reset_password_model.dart';

class ResetPasswordUseCase {
  final AuthRepo authRepo;

  ResetPasswordUseCase({required this.authRepo});
  Future<ApiResult<void>> call(ResetPasswordModel resetPasswordModel) async {
    return authRepo.resetPassword(resetPasswordModel);
  }
}
