import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/core/utils/register_lazy_if_not_registered.dart';
import 'package:sehhalink/features/home/data/data_source/home_remote_data_source.dart';
import 'package:sehhalink/features/home/data/repo_impl/home_repo_impl.dart';
import 'package:sehhalink/features/home/domain/repo/home_repo.dart';
import 'package:sehhalink/features/home/domain/use_cases/get_saved_files_use_case.dart';
import 'package:sehhalink/features/home/domain/use_cases/get_user_general_summary_use_case.dart';
import 'package:sehhalink/features/home/domain/use_cases/save_file_use_case.dart';
import 'package:sehhalink/features/home/domain/use_cases/upload_file_use_case.dart';
import 'package:sehhalink/features/home/presentation/logic/home_cubit.dart';

void homeScreenDi() {
  registerLazyIfNotRegistered<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(networkService: getIt()),
  );
  registerLazyIfNotRegistered<HomeRepo>(
    () => HomeRepoImpl(
      homeRemoteDataSource: getIt<HomeRemoteDataSource>(),
      localDataSource: getIt(),
    ),
  );
  registerLazyIfNotRegistered<UploadFileUseCase>(
    () => UploadFileUseCase(homeRepo: getIt<HomeRepo>()),
  );
  registerLazyIfNotRegistered<SaveFileUseCase>(
    () => SaveFileUseCase(homeRepo: getIt<HomeRepo>()),
  );
  registerLazyIfNotRegistered<GetSavedFilesUseCase>(
    () => GetSavedFilesUseCase(getIt<HomeRepo>()),
  );
    registerLazyIfNotRegistered<GetUserGeneralSummaryUseCase>(
      () => GetUserGeneralSummaryUseCase(remoteDataSource: getIt<HomeRemoteDataSource>(), localDataSource: getIt()),
    );

  registerLazyIfNotRegistered<HomeCubit>(
    () => HomeCubit(
      getUserGeneralSummaryUseCase: getIt<GetUserGeneralSummaryUseCase>(),
      getSavedFilesUseCase: getIt<GetSavedFilesUseCase>(),
      uploadFileUseCase: getIt<UploadFileUseCase>(),
      saveFileUseCase: getIt<SaveFileUseCase>(),
    ),
  );
}
