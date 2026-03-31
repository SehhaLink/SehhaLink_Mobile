import 'dart:io';
import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/current_user/domain/repo/current_user_repository.dart';

class UpdateCurrentUserUseCase {
  final CurrentUserRepository _repository;
  UpdateCurrentUserUseCase(this._repository);

  Future<void> call(User user, {File? imageFile}) async {
    return await _repository.updateUser(user, imageFile: imageFile);
  }
}