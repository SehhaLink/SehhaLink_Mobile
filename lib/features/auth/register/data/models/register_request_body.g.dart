// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestBody _$RegisterRequestBodyFromJson(Map<String, dynamic> json) =>
    RegisterRequestBody(
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      fullName: json['fullName'] as String,
      confirmPassword: json['confirmPassword'] as String,
      birthDate: json['birthDate'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$RegisterRequestBodyToJson(
        RegisterRequestBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'fullName': instance.fullName,
      'birthDate': instance.birthDate,
      'gender': instance.gender,
    };
