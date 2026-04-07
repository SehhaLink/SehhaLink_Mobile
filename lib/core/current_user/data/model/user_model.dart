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
  String? generalSummary;
  late String phoneNumber;
  String? profileImage;
  final files = IsarLinks<FileModel>();

  UserModel();
  UserModel.fromEntity(User user) {
    userId = user.id;
    fullName = user.fullName;
    email = user.email;
    birthDate = user.birthDate;
    gender = user.gender;
    age = user.age;
    role = user.role;
    phoneNumber = user.phoneNumber;
    profileImage = user.profileImage;
    generalSummary = user.generalSummary;
  }
  User toEntity({String? token}) {
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
      profileImage: profileImage,
      generalSummary: generalSummary,
    );
  }

  void updateFromEntity(User user) {
    userId = user.id;
    fullName = user.fullName;
    email = user.email;
    birthDate = user.birthDate;
    gender = user.gender;
    age = user.age;
    role = user.role;
    phoneNumber = user.phoneNumber;
    profileImage = user.profileImage;
    generalSummary = user.generalSummary;
  }
}
