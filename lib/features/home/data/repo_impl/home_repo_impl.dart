import 'dart:io';
import 'package:sehhalink/core/current_user/data/model/file_model.dart';
import 'package:sehhalink/core/data_source/local_data_source.dart';
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
  Future<FileModel> uploadFile(
    File file, {
    void Function(double progress)? onProgress,
  }) async {
    final fileModel = await homeRemoteDataSource.uploadFile(
      file,
      onProgress: onProgress,
    );
    await localDataSource.addFile(fileModel);
    return fileModel;
  }
}