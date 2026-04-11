import 'package:sehhalink/core/current_user/domain/repo/file_repo.dart';

class DeleteFileUseCase {
  final FileRepo _repository;
  DeleteFileUseCase(this._repository);
  Future<void> call(String fileId) => _repository.deleteFile(fileId);
}