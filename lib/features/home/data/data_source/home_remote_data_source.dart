import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sehhalink/core/networking/api_const.dart';
import 'package:sehhalink/core/networking/network_service.dart';
import 'package:sehhalink/core/current_user/data/model/file_model.dart';

abstract class HomeRemoteDataSource {
  Future<FileModel> uploadFile(
    File file, {
    void Function(double progress)? onProgress,
  });
  Future<String> getGeneralSummary();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required this.networkService});
  final NetworkService networkService;

  @override
  Future<FileModel> uploadFile(
    File file, {
    void Function(double progress)? onProgress,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    final response = await networkService.post(
      ApiConst.uploadDocument,
      formData,
      onSendProgress: (sent, total) {
        if (total > 0) onProgress?.call(sent / total);
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Upload failed with status ${response.statusCode}');
    }

    final data = response.data['data'];

    return FileModel()
      ..fileId = data['id'].toString()
      ..fileName = data['fileName'] ?? ''
      ..filePath = file.path
      ..summary = ''
      ..fileType = file.path.split('.').last
      ..createdAt = DateTime.now().toIso8601String();
  }

  @override
  Future<String> getGeneralSummary() async {
    final response = await networkService.get(ApiConst.historySummary);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch general summary');
    }
    return response.data['data']['summary'] ?? '';
  }
}
