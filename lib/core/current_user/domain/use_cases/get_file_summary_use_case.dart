// get_file_summary_use_case.dart
import 'package:sehhalink/core/current_user/domain/repo/current_user_repository.dart';
import 'package:sehhalink/core/networking/api_result.dart';

class GetFileSummaryUseCase {
  final CurrentUserRepository _repo;
  GetFileSummaryUseCase(this._repo);

  Future<ApiResult<String>> call(String fileId) => _repo.summarizeFile(fileId);
}