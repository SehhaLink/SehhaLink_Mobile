import 'dart:io';

import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/current_user/domain/repo/current_user_repository.dart';
import 'package:sehhalink/core/data_source/remote_data_source.dart';
import 'package:sehhalink/core/data_source/user_local_data_source.dart';
import 'package:sehhalink/core/service/secure_storage_service.dart';

class CurrentUserRepositoryImpl extends CurrentUserRepository {
  final UserLocalDataSource userLocalDataSource;
  final RemoteDataSource remoteDataSource;

  CurrentUserRepositoryImpl({
    required this.userLocalDataSource,
    required this.remoteDataSource,
  });
  @override
  Future<User> getCurrentUser() async {
    final userModel = await userLocalDataSource.getCurrentUser();
    final token = await SecureStorageService.getToken();
    return userModel.toEntity(token: token);
  }

  @override
  Future<void> updateProfileImage(File imageFile) async {
    await remoteDataSource.updateProfileImage(imageFile);
    await userLocalDataSource.updateProfileImage(imageFile);
  }

  @override
  Future<void> updateUser(User user, {File? imageFile}) async {
    await userLocalDataSource.updateUser(user, imageFile: imageFile);
  }

  @override
  Future<void> logout() async {
    await SecureStorageService.deleteToken();
    await userLocalDataSource.clearUserData();
  }
}
