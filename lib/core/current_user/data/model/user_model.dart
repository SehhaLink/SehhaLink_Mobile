// user_model.dart
import 'package:isar/isar.dart';
import 'package:sehhalink/core/current_user/data/model/file_model.dart';
import 'package:sehhalink/core/current_user/domain/entity/user.dart';
part 'user_model.g.dart';

@Collection()
class UserModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String userId;
  late String fullName;
  late String email;
  late String birthDate;
  late String gender;
  late int age;
  late String role;
  late String phoneNumber;
  late String token;
  String? profileImage;

  final files = IsarLinks<FileModel>();

  User toEntity() {
    return User(
      id: userId,
      fullName: fullName,
      email: email,
      birthDate: birthDate,
      gender: gender,
      age: age,
      role: role,
      phoneNumber: phoneNumber,
      token: token,
    );
  }
}
