import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sehhalink/core/current_user/data/model/file_model.dart';
import 'package:sehhalink/core/data_source/file_local_data_source.dart';
import 'package:sehhalink/core/networking/api_error_factory.dart';
import 'package:sehhalink/core/networking/api_error_handler.dart';
import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/home/data/data_source/home_remote_data_source.dart';
import 'package:sehhalink/features/home/domain/entities/general_summary_result.dart';
import 'package:sehhalink/features/home/domain/repo/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.fileLocalDataSource,
  });

  final HomeRemoteDataSource homeRemoteDataSource;
  final FileLocalDataSource fileLocalDataSource;

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
    await fileLocalDataSource.addFile(file);
  }

  @override
  Future<List<FileModel>> getSavedFiles() async {
    return await fileLocalDataSource.getUserFiles();
  }

  @override
  Future<void> deleteSavedFile(String fileId) async {
    await fileLocalDataSource.deleteFile(fileId);
  }

  @override
  Future<ApiResult<GeneralSummaryResult>> getGeneralSummary({
    bool forceRefresh = false,
  }) async {
    try {
      if (!forceRefresh) {
        final cached = await fileLocalDataSource.getCachedGeneralSummary();
        if (cached != null && cached.isNotEmpty) {
          return ApiResult.success(
            GeneralSummaryResult(summary: cached, isFromCache: true),
          );
        }
      }
      final summary = await homeRemoteDataSource.getGeneralSummary();
      await fileLocalDataSource.saveGeneralSummary(summary);
      return ApiResult.success(
        GeneralSummaryResult(summary: summary, isFromCache: false),
      );
    } on DioException catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    } catch (e) {
      return ApiResult.error(ApiErrorFactory.defaultError);
    }
  }
}
