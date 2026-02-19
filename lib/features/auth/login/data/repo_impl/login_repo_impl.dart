
import 'package:sehhalink/core/data_source/remote_data_source.dart';
import 'package:sehhalink/core/networking/api_error_handler.dart';
import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/auth/login/data/models/login_request_body.dart';
import 'package:sehhalink/features/auth/login/domain/repos/login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  final RemoteDataSource remoteDataSource;

  LoginRepoImpl({required this.remoteDataSource});
  @override
  @override
  Future<ApiResult<void>> login(LoginRequestBody loginRequest) async {
    try {
      await remoteDataSource.login(loginRequest);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }
}
