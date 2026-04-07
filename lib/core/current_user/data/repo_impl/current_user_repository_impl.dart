import 'dart:io';

import 'package:sehhalink/core/current_user/data/model/file_model.dart';
import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';
import 'package:sehhalink/core/current_user/domain/repo/current_user_repository.dart';
import 'package:sehhalink/core/data_source/local_data_source.dart';
import 'package:sehhalink/core/data_source/remote_data_source.dart';
import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/core/service/secure_storage_service.dart';

class CurrentUserRepositoryImpl extends CurrentUserRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  CurrentUserRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });
  @override
  Future<User> getCurrentUser() async {
    final userModel = await localDataSource.getCurrentUser();
    final token = await SecureStorageService.getToken();
    return userModel.toEntity(token: token);
  }

  @override
  Future<String?> getCachedGeneralSummary() async {
    return await localDataSource.getCachedGeneralSummary();
  }

  @override
  Future<void> saveGeneralSummary(String summary) async {
    await localDataSource.saveGeneralSummary(summary);
  }

  @override
  Future<void> updateProfileImage(File imageFile) async {
    await remoteDataSource.updateProfileImage(imageFile);
    await localDataSource.updateProfileImage(imageFile);
  }

  @override
  Future<ApiResult<String>> summarizeFile(String fileId) async {
    return await localDataSource.summarizeFile(fileId);
  }

  @override
  Future<void> updateUser(User user, {File? imageFile}) async {
    await localDataSource.updateUser(user, imageFile: imageFile);
  }

  @override
  Future<void> addFile(UserFile file) async {
    final fileModel = FileModel.fromEntity(file);
    await localDataSource.addFile(fileModel);
  }

  @override
  Future<void> logout() async {
    await SecureStorageService.deleteToken();
    await localDataSource.clearUserData();
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
