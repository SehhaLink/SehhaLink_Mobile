import 'package:sehhalink/core/data_source/remote_data_source.dart';
import 'package:sehhalink/core/networking/api_error_handler.dart';
import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/auth/register/data/models/register_request_body.dart';
import 'package:sehhalink/features/auth/register/domain/repo/register_repo.dart';

class RegisterRepoImpl implements RegisterRepo {
  final RemoteDataSource remoteDataSource;

  RegisterRepoImpl(this.remoteDataSource);

  @override
  Future<ApiResult<void>> register(
    RegisterRequestBody registerRequestBody,
  ) async {
    try {
      await remoteDataSource.register(registerRequestBody);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error((ApiErrorHandler.handle(e)));
    }
  }
}
