import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sehhalink/core/current_user/data/model/file_model.dart';
import 'package:sehhalink/core/current_user/data/model/user_model.dart';
import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/service/cache_exception.dart';
import 'package:sehhalink/core/service/isar_service.dart';
import 'package:sehhalink/core/service/secure_storage_service.dart';

abstract class LocalDataSource {
  Future<UserModel> getCurrentUser();
  Future<void> saveUser(UserModel user);
  Future<void> updateUser(User user, {File? imageFile});
  Future<void> updateProfileImage(File imageFile);
  Future<void> logout();
  Future<bool> hasCurrentUser();
  Future<bool> hasValidToken();
  Future<void> addFile(FileModel file);
  Future<List<FileModel>> getUserFiles();
  Future<void> deleteFile(String fileId);
}

class LocalDataSourceImpl extends LocalDataSource {
  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final isar = await IsarService.instance;
      final user = await isar.userModels.where().findFirst();
      if (user == null) throw CacheException('No user found');
      return user;
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException('Failed to get user: $e');
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      final isar = await IsarService.instance;
      await isar.writeTxn(() async {
        await isar.userModels.put(user);
      });
    } catch (e) {
      throw CacheException('Failed to save user: $e');
    }
  }

  /*
     this function 
   */

  @override
  Future<void> updateUser(User user, {File? imageFile}) async {
    try {
      final isar = await IsarService.instance;

      final existing = await isar.userModels
          .filter()
          .userIdEqualTo(user.id)
          .findFirst();

      if (existing == null) throw CacheException('User not found');

      if (imageFile != null) {
        final oldPath = existing.profileImage;

        final appDir = await getApplicationDocumentsDirectory();
        final localPath = '${appDir.path}/profile_images';
        final directory = Directory(localPath);
        if (!await directory.exists()) await directory.create(recursive: true);

        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final saved = await imageFile.copy('$localPath/profile_$timestamp.png');
        existing.profileImage = saved.path;

        if (oldPath != null && oldPath.isNotEmpty) {
          final old = File(oldPath);
          if (await old.exists()) await old.delete();
        }
      }

      existing.updateFromEntity(user);

      await isar.writeTxn(() async {
        await isar.userModels.put(existing);
      });
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException('Failed to update user: $e');
    }
  }

  @override
  Future<void> updateProfileImage(File imageFile) async {
    try {
      final isar = await IsarService.instance;
      final existing = await isar.userModels.where().findFirst();
      if (existing == null) throw CacheException('User not found');

      final oldPath = existing.profileImage;

      final appDir = await getApplicationDocumentsDirectory();
      final localPath = '${appDir.path}/profile_images';
      final directory = Directory(localPath);
      if (!await directory.exists()) await directory.create(recursive: true);

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final saved = await imageFile.copy('$localPath/profile_$timestamp.png');

      existing.profileImage = saved.path;

      await isar.writeTxn(() async {
        await isar.userModels.put(existing);
      });

      if (oldPath != null && oldPath.isNotEmpty) {
        final old = File(oldPath);
        if (await old.exists()) await old.delete();
      }
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException('Failed to update profile image: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      final isar = await IsarService.instance;
      await isar.writeTxn(() async {
        await isar.userModels.clear();
      });
      await SecureStorageService.deleteToken();
    } catch (e) {
      throw CacheException('Failed to logout: $e');
    }
  }

  @override
  Future<bool> hasCurrentUser() async {
    try {
      final isar = await IsarService.instance;
      final count = await isar.userModels.count();
      return count > 0;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> hasValidToken() async {
    return await SecureStorageService.hasValidToken();
  }

  @override
  Future<void> addFile(FileModel file) async {
    try {
      final isar = await IsarService.instance;
      final user = await getCurrentUser();
      await isar.writeTxn(() async {
        await isar.fileModels.put(file);
        user.files.add(file);
        await user.files.save();
      });
    } catch (e) {
      throw CacheException('Failed to add file: $e');
    }
  }

  @override
  Future<List<FileModel>> getUserFiles() async {
    try {
      final user = await getCurrentUser();
      await user.files.load();
      return user.files.toList();
    } catch (e) {
      throw CacheException('Failed to get files: $e');
    }
  }

  @override
  Future<void> deleteFile(String fileId) async {
    try {
      final isar = await IsarService.instance;
      await isar.writeTxn(() async {
        final file = await isar.fileModels
            .filter()
            .fileIdEqualTo(fileId)
            .findFirst();
        if (file != null) await isar.fileModels.delete(file.id);
      });
    } catch (e) {
      throw CacheException('Failed to delete file: $e');
    }
  }
}
