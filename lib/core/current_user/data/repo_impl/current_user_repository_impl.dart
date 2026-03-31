import 'dart:io';

import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/current_user/domain/repo/current_user_repository.dart';
import 'package:sehhalink/core/data_source/local_data_source.dart';

class CurrentUserRepositoryImpl extends CurrentUserRepository {
  final LocalDataSource localDataSource;

  CurrentUserRepositoryImpl({required this.localDataSource});
  @override
  Future<User> getCurrentUser() async {
    final userModel = await localDataSource.getCurrentUser();
    return userModel.toEntity();
  }

  @override
  Future<void> updateUser(User user, {File? imageFile}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
