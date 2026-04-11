import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sehhalink/core/networking/api_const.dart';
import 'package:sehhalink/core/networking/network_service.dart';

abstract class RemoteDataSource {
  Future<String?> updateProfileImage(File image);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final NetworkService networkService;

  RemoteDataSourceImpl(this.networkService);

  @override
  Future<String?> updateProfileImage(File image) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    });

    final response = await networkService.post(
      ApiConst.updateProfileImage,
      formData,
    );
    return response.data["imageUrl"];
  }
}
