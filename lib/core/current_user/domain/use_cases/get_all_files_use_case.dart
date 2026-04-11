import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';
import 'package:sehhalink/core/current_user/domain/repo/file_repo.dart';

class GetUserFilesUseCase {
  final FileRepo _repository;
  GetUserFilesUseCase(this._repository);
  Future<List<UserFile>> call() => _repository.getUserFiles();
}