// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseBody _$LoginResponseBodyFromJson(Map<String, dynamic> json) =>
    LoginResponseBody(
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      token: json['token'] as String,
      fullName: json['fullName'] as String,
      birthDate: json['birthDate'] as String,
      gender: json['gender'] as String,
      age: (json['age'] as num).toInt(),
      role: json['role'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$LoginResponseBodyToJson(LoginResponseBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'token': instance.token,
      'birthDate': instance.birthDate,
      'gender': instance.gender,
      'age': instance.age,
      'role': instance.role,
    };
