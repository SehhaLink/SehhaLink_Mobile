import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sehhalink/core/networking/api_const.dart';
import 'package:sehhalink/core/networking/network_service.dart';

abstract class HomeRemoteDataSource {
  Future<void> uploadFile(
    File file, {
    void Function(double progress)? onProgress,
  });
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required this.networkService});

  final NetworkService networkService;

  @override
  Future<void> uploadFile(
    File file, {
    void Function(double progress)? onProgress,
  }) async {
    try {
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
    } catch (e) {
      rethrow;
    }
  }
}