import 'package:json_annotation/json_annotation.dart';
part 'register_request_body.g.dart';

@JsonSerializable()
class RegisterRequestBody {
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final String fullName;
  final int? age;
  final DateTime? birthDate;
  final String? gender;

  RegisterRequestBody({
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.fullName,
    required this.confirmPassword,
    required this.age,
    required this.birthDate,
    required this.gender,
  });
  factory RegisterRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestBodyFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestBodyToJson(this);
}
