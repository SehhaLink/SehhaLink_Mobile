import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';
import 'package:sehhalink/core/current_user/domain/repo/file_repo.dart';

class AddFileUseCase {
  final FileRepo _repository;
  AddFileUseCase(this._repository);
  Future<void> call(UserFile file) => _repository.addFile(file);
}