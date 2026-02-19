import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/auth/register/data/models/register_request_body.dart';
import 'package:sehhalink/features/auth/register/domain/repo/register_repo.dart';

class RegisterUseCase {
  final RegisterRepo registerRepo;
  RegisterUseCase(this.registerRepo);

  Future<ApiResult<void>> register(RegisterRequestBody body) {
    return registerRepo.register(body);
  }
}
