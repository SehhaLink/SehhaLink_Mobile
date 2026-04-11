import 'package:sehhalink/core/current_user/data/repo_impl/current_user_repository_impl.dart';
import 'package:sehhalink/core/current_user/data/repo_impl/file_repo_impl.dart';
import 'package:sehhalink/core/current_user/domain/repo/current_user_repository.dart';
import 'package:sehhalink/core/current_user/domain/repo/file_repo.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/add_file_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/delete_file_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/get_all_files_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/get_current_user_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/get_file_summary_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/logout_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/update_current_user.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/update_profile_image_use_case.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_logic/current_user_cubit.dart';
import 'package:sehhalink/core/current_user/presentation/logic/file_logic/files_cubit.dart';
import 'package:sehhalink/core/data_source/file_remote_data_source.dart';
import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/core/utils/register_lazy_if_not_registered.dart';

void currentUserDi() {
  registerLazyIfNotRegistered<FileRemoteDataSource>(
    () => FileRemoteDataSourceImpl(networkService: getIt()),
  );
  registerLazyIfNotRegistered<FileRepo>(
    () => FileRepoImpl(
      fileLocalDataSource: getIt(),
      fileRemoteDataSource: getIt(),
    ),
  );

  registerLazyIfNotRegistered<CurrentUserRepository>(
    () => CurrentUserRepositoryImpl(
      userLocalDataSource: getIt(),
      remoteDataSource: getIt(),
    ),
  );
  registerLazyIfNotRegistered<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(getIt()),
  );
  registerLazyIfNotRegistered<UpdateCurrentUserUseCase>(
    () => UpdateCurrentUserUseCase(getIt()),
  );
  registerLazyIfNotRegistered<UpdateProfileImageUseCase>(
    () => UpdateProfileImageUseCase(getIt()),
  );
  registerLazyIfNotRegistered<AddFileUseCase>(() => AddFileUseCase(getIt()));
  registerLazyIfNotRegistered<DeleteFileUseCase>(
    () => DeleteFileUseCase(getIt()),
  );
  registerLazyIfNotRegistered<GetUserFilesUseCase>(
    () => GetUserFilesUseCase(getIt()),
  );
  registerLazyIfNotRegistered<GetFileSummaryUseCase>(
    () => GetFileSummaryUseCase(getIt()),
  );

  registerLazyIfNotRegistered<LogoutUseCase>(() => LogoutUseCase(getIt()));
  registerLazyIfNotRegistered<CurrentUserCubit>(
    () => CurrentUserCubit(
      logoutUseCase: getIt(),
      updateProfileImageUseCase: getIt(),
      getCurrentUserUseCase: getIt(),
      updateUserUseCase: getIt(),
    ),
  );
  registerLazyIfNotRegistered<FilesCubit>(
    () => FilesCubit(
      getUserFilesUseCase: getIt(),
      addFileUseCase: getIt(),
      deleteFileUseCase: getIt(),
      getFileSummaryUseCase: getIt(),
    ),
  );
}
