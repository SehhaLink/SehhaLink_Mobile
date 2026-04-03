import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_model.g.dart';
@JsonSerializable()
class ResetPasswordModel {
  final String email;
  final String otp;
  final String newPassword;
  final String confirmNewPassword;

  ResetPasswordModel({
    required this.email,
    required this.otp,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordModelToJson(this);
}
