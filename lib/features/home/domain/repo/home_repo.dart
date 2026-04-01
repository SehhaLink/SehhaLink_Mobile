import 'dart:io';
import 'package:sehhalink/core/current_user/data/model/file_model.dart';
abstract class HomeRepo {
  Future<FileModel> uploadFile(
    File file, {
    void Function(double progress)? onProgress,
  });
   Future<void> saveFile(FileModel file); 
}