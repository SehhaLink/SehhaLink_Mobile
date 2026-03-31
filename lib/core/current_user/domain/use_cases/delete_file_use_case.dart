import 'package:sehhalink/core/current_user/domain/repo/current_user_repository.dart';

class DeleteFileUseCase {
  final CurrentUserRepository _repository;
  DeleteFileUseCase(this._repository);
  Future<void> call(String fileId) => _repository.deleteFile(fileId);
}