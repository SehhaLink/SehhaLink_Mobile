import 'dart:io';
import 'package:sehhalink/core/current_user/data/model/file_model.dart';
import 'package:sehhalink/core/networking/api_result.dart';

abstract class HomeRepo {
  Future<ApiResult<FileModel>> uploadFile(
    File file, {
    void Function(double progress)? onProgress,
  });
  Future<void> saveFile(FileModel file);

  Future<List<FileModel>> getSavedFiles();
  Future<void> deleteSavedFile(String fileId);
}
