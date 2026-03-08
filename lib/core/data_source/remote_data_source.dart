import 'package:sehhalink/core/networking/api_const.dart';
import 'package:sehhalink/core/networking/network_service.dart';
import 'package:sehhalink/features/auth/forget_password/data/models/reset_password_model.dart';
import 'package:sehhalink/features/auth/login/data/models/login_request_body.dart';
import 'package:sehhalink/features/auth/login/data/models/login_response_body.dart';
import 'package:sehhalink/features/auth/register/data/models/register_request_body.dart';

abstract class RemoteDataSource {
  Future<bool> register(RegisterRequestBody registerRequestBody);
  Future<LoginResponseBody> login(LoginRequestBody loginRequest);
  Future<bool> forgetPassword(String email);
  Future<bool> resetPassword(ResetPasswordModel resetModel);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final NetworkService networkService;

  RemoteDataSourceImpl(this.networkService);

  @override
  Future<bool> register(RegisterRequestBody registerRequestBody) async {
    final response = await networkService.post(
      ApiConst.register,
      registerRequestBody.toJson(),
    );

    return response.data['isSuccess'];
  }

  @override
  Future<LoginResponseBody> login(LoginRequestBody loginRequest) async {
    final response = await networkService.post(
      ApiConst.login,
      loginRequest.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception(response.data['message']);
    }

    return LoginResponseBody.fromJson(response.data);
  }

  @override
  Future<bool> forgetPassword(String email) async {
    final response = await networkService.post(ApiConst.forgetPassword, {
      "email": email,
    });
    return response.data["success"] ?? false;
  }

  @override
  Future<bool> resetPassword(ResetPasswordModel resetModel) async {
    final response = await networkService.post(
      ApiConst.forgetPassword,
      resetModel.toJson(),
    );
    return response.data["success"] ?? false;
  }
}
