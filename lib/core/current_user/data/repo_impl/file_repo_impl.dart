import 'package:dio/dio.dart';
import 'package:sehhalink/core/current_user/data/model/file_model.dart';
import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';
import 'package:sehhalink/core/current_user/domain/repo/file_repo.dart';
import 'package:sehhalink/core/data_source/file_local_data_source.dart';
import 'package:sehhalink/core/data_source/file_remote_data_source.dart';
import 'package:sehhalink/core/networking/api_error_factory.dart';
import 'package:sehhalink/core/networking/api_error_handler.dart';
import 'package:sehhalink/core/networking/api_result.dart';

class FileRepoImpl extends FileRepo {
  final FileLocalDataSource fileLocalDataSource;
  final FileRemoteDataSource fileRemoteDataSource;

  FileRepoImpl({
    required this.fileLocalDataSource,
    required this.fileRemoteDataSource,
  });

  @override
  Future<void> addFile(UserFile file) async {
    final fileModel = FileModel.fromEntity(file);
    await fileLocalDataSource.addFile(fileModel);
  }

  @override
  Future<List<UserFile>> getUserFiles() async {
    final files = await fileLocalDataSource.getUserFiles();
    return files.map((f) => f.toEntity()).toList();
  }

  @override
  Future<void> deleteFile(String fileId) async {
    await fileLocalDataSource.deleteFile(fileId);
  }

  @override
  Future<ApiResult<String>> summarizeFile(String fileId) async {
    try {
      final cached = await fileLocalDataSource.getCachedSummary(fileId);
      if (cached != null && cached.isNotEmpty) {
        return ApiResult.success(cached);
      }
      final summary = await fileRemoteDataSource.summarizeFile(fileId);
      await fileLocalDataSource.updateFileSummary(fileId, summary);
      return ApiResult.success(summary);
    } on DioException catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    } catch (e) {
      return ApiResult.error(ApiErrorFactory.defaultError);
    }
  }
}
