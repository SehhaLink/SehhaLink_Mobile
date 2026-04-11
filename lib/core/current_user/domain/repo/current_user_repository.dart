import 'dart:io';

import 'package:sehhalink/core/current_user/domain/entity/user.dart';

abstract class CurrentUserRepository {
  Future<User> getCurrentUser();
  Future<void> updateUser(User user, {File? imageFile});
  Future<void> updateProfileImage(File imageFile);
  Future<void> logout();
}
