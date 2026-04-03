import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/home/domain/repo/home_repo.dart';

class GetUserGeneralSummaryUseCase {
  final HomeRepo repository;

  GetUserGeneralSummaryUseCase(this.repository);

  Future<ApiResult<String>> call() async {
    return await repository.getGeneralSummary();
  }
}