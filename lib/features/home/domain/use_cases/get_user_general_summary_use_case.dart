import 'package:sehhalink/core/data_source/local_data_source.dart';
import 'package:sehhalink/core/networking/api_error_handler.dart';
import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/home/data/data_source/home_remote_data_source.dart';

class GeneralSummaryResult {
  final String summary;
  final bool isFromCache;
  const GeneralSummaryResult({required this.summary, required this.isFromCache});
}

class GetUserGeneralSummaryUseCase {
  final HomeRemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  GetUserGeneralSummaryUseCase({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<ApiResult<GeneralSummaryResult>> call({bool forceRefresh = false}) async {
    try {
      if (!forceRefresh) {
        final cached = await localDataSource.getCachedGeneralSummary();
        if (cached != null && cached.isNotEmpty) {
          return ApiResult.success(
            GeneralSummaryResult(summary: cached, isFromCache: true),
          );
        }
      }

      final summary = await remoteDataSource.getGeneralSummary();
      await localDataSource.saveGeneralSummary(summary);

      return ApiResult.success(
        GeneralSummaryResult(summary: summary, isFromCache: false),
      );
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }
}