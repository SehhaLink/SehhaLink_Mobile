

import 'package:sehhalink/core/data_source/remote_data_source.dart';
import 'package:sehhalink/core/networking/api_error_handler.dart';
import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/auth/forget_password/data/models/reset_password_model.dart';
import 'package:sehhalink/features/auth/forget_password/domain/repo/forget_password_repo.dart';

class ForgetPasswordRepoImpl implements ForgetPasswordRepo {
  final RemoteDataSource remoteDataSource;
  ForgetPasswordRepoImpl({required this.remoteDataSource});
  String userEmail = '';
  @override
  Future<ApiResult<bool>> forgetPassword(String email) async {
    try {
      userEmail = email;
      final result = await remoteDataSource.forgetPassword(email);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<bool>> resetPassword(ResetPasswordModel resetmodel)async {
     try {
      final result = await remoteDataSource.resetPassword(resetmodel);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }
  


}
