import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_body.g.dart';

@JsonSerializable()
class LoginResponseBody {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String country;
  final String city;
  final String address;
  final String role;
  final String loginToken;

  LoginResponseBody({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.country,
    required this.city,
    required this.address,
    required this.role,
    required this.loginToken,
  });

  factory LoginResponseBody.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseBodyToJson(this);
}
