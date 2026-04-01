import 'dart:io';

import 'package:sehhalink/core/current_user/data/model/file_model.dart';
import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';
import 'package:sehhalink/core/current_user/domain/repo/current_user_repository.dart';
import 'package:sehhalink/core/data_source/local_data_source.dart';
import 'package:sehhalink/core/service/secure_storage_service.dart';

class CurrentUserRepositoryImpl extends CurrentUserRepository {
  final LocalDataSource localDataSource;

  CurrentUserRepositoryImpl({required this.localDataSource});
  @override
  Future<User> getCurrentUser() async {
    final userModel = await localDataSource.getCurrentUser();
    final token = await SecureStorageService.getToken();
    return userModel.toEntity(token: token);
  }

  @override
  Future<void> updateUser(User user, {File? imageFile}) async {
    await localDataSource.updateUser(user);
  }

  @override
  Future<void> addFile(UserFile file) async {
    final fileModel = FileModel.fromEntity(file);
    await localDataSource.addFile(fileModel);
  }

  @override
  Future<List<UserFile>> getUserFiles() async {
    final files = await localDataSource.getUserFiles();
    return files.map((f) => f.toEntity()).toList();
  }

  @override
  Future<void> deleteFile(String fileId) async {
    await localDataSource.deleteFile(fileId);
  }
}
