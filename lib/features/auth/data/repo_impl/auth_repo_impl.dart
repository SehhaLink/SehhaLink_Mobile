import 'package:sehhalink/core/current_user/data/model/user_model.dart';
import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/data_source/user_local_data_source.dart';
import 'package:sehhalink/core/networking/api_error_handler.dart';
import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/core/service/secure_storage_service.dart';
import 'package:sehhalink/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:sehhalink/features/auth/domain/repo/auth_repo.dart';
import 'package:sehhalink/features/auth/data/model/reset_password_model.dart';
import 'package:sehhalink/features/auth/data/model/login_request_body.dart';
import 'package:sehhalink/features/auth/data/model/register_request_body.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  String userEmail = '';

  AuthRepoImpl({
    required this.authRemoteDataSource,
    required this.userLocalDataSource,
  });
  @override
  Future<ApiResult<bool>> forgetPassword(String email) async {
    try {
      userEmail = email;
      final result = await authRemoteDataSource.forgetPassword(email);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> login(LoginRequestBody loginRequest) async {
    try {
      final remoteUser = await authRemoteDataSource.login(loginRequest);
      await SecureStorageService.saveToken(remoteUser.token);

      String? localImagePath;
      if (remoteUser.profilePictureUrl != null &&
          remoteUser.profilePictureUrl!.isNotEmpty) {
        localImagePath = await userLocalDataSource.downloadAndCacheImage(
          remoteUser.profilePictureUrl!,
        );
      }

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
          profileImage: localImagePath,
        ),
      );

      await userLocalDataSource.saveUser(userModel);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> register(
    RegisterRequestBody registerRequestBody,
  ) async {
    try {
      await authRemoteDataSource.register(registerRequestBody);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error((ApiErrorHandler.handle(e)));
    }
  }

  @override
  Future<ApiResult<bool>> resetPassword(ResetPasswordModel resetmodel) async {
    try {
      final result = await authRemoteDataSource.resetPassword(resetmodel);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }
}
