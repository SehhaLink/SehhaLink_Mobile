import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sehhalink/core/current_user/data/model/file_model.dart';
import 'package:sehhalink/core/data_source/local_data_source.dart';
import 'package:sehhalink/core/networking/api_error_factory.dart';
import 'package:sehhalink/core/networking/api_error_handler.dart';
import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/home/data/data_source/home_remote_data_source.dart';
import 'package:sehhalink/features/home/domain/repo/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.localDataSource,
  });

  final HomeRemoteDataSource homeRemoteDataSource;
  final LocalDataSource localDataSource;

  @override
  Future<ApiResult<FileModel>> uploadFile(
    File file, {
    void Function(double progress)? onProgress,
  }) async {
    try {
      final fileModel = await homeRemoteDataSource.uploadFile(
        file,
        onProgress: onProgress,
      );
      return ApiResult.success(fileModel);
    } on DioException catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    } catch (e) {
      return ApiResult.error(ApiErrorFactory.defaultError);
    }
  }

  @override
  Future<void> saveFile(FileModel file) async {
    await localDataSource.addFile(file);
  }

  @override
  Future<List<FileModel>> getSavedFiles() async {
    return await localDataSource.getUserFiles(); 
  }

  @override
  Future<void> deleteSavedFile(String fileId) async {
    await localDataSource.deleteFile(fileId); 
  }
}
