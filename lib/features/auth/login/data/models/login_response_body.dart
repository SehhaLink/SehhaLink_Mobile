import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_body.g.dart';

@JsonSerializable()
class LoginResponseBody {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String loginToken;

  LoginResponseBody({
    required this.email,
    required this.phoneNumber,
    required this.loginToken,
    required this.fullName,
  });

  factory LoginResponseBody.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseBodyToJson(this);
}
