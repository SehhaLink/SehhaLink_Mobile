import 'package:sehhalink/core/current_user/data/model/user_model.dart';
import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/data_source/local_data_source.dart';
import 'package:sehhalink/core/data_source/remote_data_source.dart';
import 'package:sehhalink/core/networking/api_error_handler.dart';
import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/core/service/secure_storage_service.dart';
import 'package:sehhalink/features/auth/login/data/models/login_request_body.dart';
import 'package:sehhalink/features/auth/login/domain/repos/login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  LoginRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<ApiResult<void>> login(LoginRequestBody loginRequest) async {
    try {
      final remoteUser = await remoteDataSource.login(loginRequest);

      await SecureStorageService.saveToken(remoteUser.token);

      final userModel = UserModel.fromEntity(
        User(
          id: remoteUser.id,
          fullName: remoteUser.fullName,
          email: remoteUser.email,
          birthDate: remoteUser.birthDate,
          gender: remoteUser.gender,
          age: remoteUser.age,
          role: remoteUser.role,
          phoneNumber: remoteUser.phoneNumber,
        ),
      );
      await localDataSource.saveUser(userModel);

      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }
}
