import 'package:sehhalink/core/current_user/data/model/file_model.dart';
import 'package:sehhalink/features/home/domain/repo/home_repo.dart';

class GetSavedFilesUseCase {
  final HomeRepo repository;

  GetSavedFilesUseCase(this.repository);

  Future<List<FileModel>> call() async {
    return await repository.getSavedFiles();
  }
}