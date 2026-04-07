import 'dart:io';

import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';
import 'package:sehhalink/core/networking/api_result.dart';

abstract class CurrentUserRepository {
  Future<User> getCurrentUser();
  Future<void> updateUser(User user, {File? imageFile});
  Future<void> updateProfileImage(File imageFile);
  Future<void> addFile(UserFile file);
  Future<List<UserFile>> getUserFiles();
  Future<void> deleteFile(String fileId);
  Future<void> logout();
  Future<ApiResult<String>> summarizeFile(String fileId);
  Future<String?> getCachedGeneralSummary();
Future<void> saveGeneralSummary(String summary);
}
