import 'dart:io';

import 'package:sehhalink/features/home/data/data_source/home_remote_data_source.dart';
import 'package:sehhalink/features/home/domain/repo/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl({required this.homeRemoteDataSource});

  final HomeRemoteDataSource homeRemoteDataSource;

  @override
  Future<void> uploadFile(
    File file, {
    void Function(double progress)? onProgress,
  }) async {
    try {
      await homeRemoteDataSource.uploadFile(file, onProgress: onProgress);
    } catch (e) {
      rethrow;
    }
  }
}