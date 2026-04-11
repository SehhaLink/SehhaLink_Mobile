import 'package:sehhalink/core/current_user/domain/repo/file_repo.dart';
import 'package:sehhalink/core/networking/api_result.dart';

class GetFileSummaryUseCase {
  final FileRepo _repo;
  GetFileSummaryUseCase(this._repo);

  Future<ApiResult<String>> call(String fileId) => _repo.summarizeFile(fileId);
}