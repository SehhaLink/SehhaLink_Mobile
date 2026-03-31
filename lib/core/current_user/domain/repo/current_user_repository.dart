import 'dart:io';

import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';

abstract class CurrentUserRepository {
  Future<User> getCurrentUser();
  Future<void> updateUser(User user, {File? imageFile});

  // files
  Future<void> addFile(UserFile file);
  Future<List<UserFile>> getUserFiles();
  Future<void> deleteFile(String fileId);
}