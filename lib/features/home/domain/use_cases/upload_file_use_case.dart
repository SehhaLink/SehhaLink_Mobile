import 'dart:io';
import 'package:sehhalink/core/current_user/data/model/file_model.dart';
import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/home/domain/repo/home_repo.dart';
class UploadFileUseCase {
  UploadFileUseCase({required this.homeRepo});
  final HomeRepo homeRepo;
  Future<ApiResult<FileModel>> call(
    File file, {
    void Function(double progress)? onProgress,
  }) async {
    return await homeRepo.uploadFile(file, onProgress: onProgress);
  }
}