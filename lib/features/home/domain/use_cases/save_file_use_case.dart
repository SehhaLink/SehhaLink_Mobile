import 'package:sehhalink/core/current_user/data/model/file_model.dart';
import 'package:sehhalink/features/home/domain/repo/home_repo.dart';

class SaveFileUseCase {
  SaveFileUseCase({required this.homeRepo});
  final HomeRepo homeRepo;

  Future<void> call(FileModel file) async {
    await homeRepo.saveFile(file);
  }
}