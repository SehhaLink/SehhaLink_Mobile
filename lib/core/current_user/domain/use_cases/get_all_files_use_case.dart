import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';
import 'package:sehhalink/core/current_user/domain/repo/current_user_repository.dart';

class GetUserFilesUseCase {
  final CurrentUserRepository _repository;
  GetUserFilesUseCase(this._repository);
  Future<List<UserFile>> call() => _repository.getUserFiles();
}