import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_body.g.dart';

@JsonSerializable()
class LoginResponseBody {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String token;
  final String birthDate;
  final String gender;
  final int age;
  final String role;
  final String? profilePictureUrl;

  LoginResponseBody({
    required this.email,
    required this.phoneNumber,
    required this.token,
    required this.fullName,
    required this.birthDate,
    required this.gender,
    required this.age,
    required this.role,
    required this.id, this.profilePictureUrl,
  });

  factory LoginResponseBody.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseBodyToJson(this);
}
