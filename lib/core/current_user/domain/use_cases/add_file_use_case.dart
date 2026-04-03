import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';
import 'package:sehhalink/core/current_user/domain/repo/current_user_repository.dart';

class AddFileUseCase {
  final CurrentUserRepository _repository;
  AddFileUseCase(this._repository);
  Future<void> call(UserFile file) => _repository.addFile(file);
}