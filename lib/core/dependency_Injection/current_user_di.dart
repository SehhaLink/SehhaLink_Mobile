import 'package:sehhalink/core/current_user/data/repo_impl/current_user_repository_impl.dart';
import 'package:sehhalink/core/current_user/domain/repo/current_user_repository.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/add_file_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/delete_file_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/get_all_files_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/get_current_user_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/update_current_user.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/update_profile_image_use_case.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_cubit.dart';
import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/core/utils/register_lazy_if_not_registered.dart';

void currentUserDi() {
  registerLazyIfNotRegistered<CurrentUserRepository>(
    () => CurrentUserRepositoryImpl(localDataSource: getIt()),
  );
  registerLazyIfNotRegistered<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(getIt()),
  );
  registerLazyIfNotRegistered<UpdateCurrentUserUseCase>(
    () => UpdateCurrentUserUseCase(getIt()),
  );
  registerLazyIfNotRegistered<AddFileUseCase>(() => AddFileUseCase(getIt()));
  registerLazyIfNotRegistered<DeleteFileUseCase>(
    () => DeleteFileUseCase(getIt()),
  );
  registerLazyIfNotRegistered<GetUserFilesUseCase>(
    () => GetUserFilesUseCase(getIt()),
  );
  registerLazyIfNotRegistered<UpdateProfileImageUseCase>(
    () => UpdateProfileImageUseCase(getIt()),
  );

  registerLazyIfNotRegistered<CurrentUserCubit>(
    () => CurrentUserCubit(
      updateProfileImageUseCase: getIt(),
      getCurrentUserUseCase: getIt(),
      updateUserUseCase: getIt(),
      addFileUseCase: getIt(),
      getUserFilesUseCase: getIt(),
      deleteFileUseCase: getIt(),
    ),
  );
}
