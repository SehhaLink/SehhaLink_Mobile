import 'dart:io';
import 'package:sehhalink/core/current_user/domain/repo/current_user_repository.dart';

class UpdateProfileImageUseCase {
  final CurrentUserRepository _repository;
  UpdateProfileImageUseCase(this._repository);

  Future<void> call(File imageFile) async {
    return await _repository.updateProfileImage(imageFile);
  }
}