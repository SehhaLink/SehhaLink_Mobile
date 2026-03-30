import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/core/utils/register_lazy_if_not_registered.dart';
import 'package:sehhalink/features/home/data/data_source/home_remote_data_source.dart';
import 'package:sehhalink/features/home/data/repo_impl/home_repo_impl.dart';
import 'package:sehhalink/features/home/domain/repo/home_repo.dart';
import 'package:sehhalink/features/home/domain/use_cases/upload_file_use_case.dart';
import 'package:sehhalink/features/home/presentation/logic/home_cubit.dart';

void homeScreenDi() {
  if (getIt.isRegistered<HomeCubit>()) {
    return;
  }

  registerLazyIfNotRegistered<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(networkService: getIt()),
  );

  registerLazyIfNotRegistered<HomeRepo>(
    () => HomeRepoImpl(homeRemoteDataSource: getIt<HomeRemoteDataSource>()),
  );

  // Register UseCase
  registerLazyIfNotRegistered<UploadFileUseCase>(
    () => UploadFileUseCase(homeRepo: getIt<HomeRepo>()),
  );

  // Register Cubit
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(uploadFileUseCase: getIt<UploadFileUseCase>()),
  );
}
