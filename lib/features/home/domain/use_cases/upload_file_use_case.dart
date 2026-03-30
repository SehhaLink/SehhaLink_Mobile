import 'dart:io';

import 'package:sehhalink/features/home/domain/repo/home_repo.dart';

class UploadFileUseCase {
  UploadFileUseCase({required this.homeRepo});

  final HomeRepo homeRepo;

  Future<void> call(
    File file, {
    void Function(double progress)? onProgress,
  }) async {
    await homeRepo.uploadFile(file, onProgress: onProgress);
  }
}