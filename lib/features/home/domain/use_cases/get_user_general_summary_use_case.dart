import 'package:sehhalink/core/networking/api_result.dart';
import 'package:sehhalink/features/home/domain/entities/general_summary_result.dart';
import 'package:sehhalink/features/home/domain/repo/home_repo.dart';


class GetUserGeneralSummaryUseCase {
  final HomeRepo homeRepo;

  GetUserGeneralSummaryUseCase({required this.homeRepo});

  Future<ApiResult<GeneralSummaryResult>> call({
    bool forceRefresh = false,
  }) async {
    return await homeRepo.getGeneralSummary(forceRefresh: forceRefresh);
  }
}
