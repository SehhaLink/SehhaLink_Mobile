

import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/features/auth/forget_password/data/repo_impl/forget_password_repo_impl.dart';
import 'package:sehhalink/features/auth/forget_password/domain/repo/forget_password_repo.dart';
import 'package:sehhalink/features/auth/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:sehhalink/features/auth/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:sehhalink/features/auth/forget_password/presentation/logic/forget_password_cubit.dart';

void forgetPasswordScreenDi() {
  if (getIt.isRegistered<ForgetPasswordCubit>()) return;

  getIt.registerLazySingleton<ForgetPasswordRepo>(
    () => ForgetPasswordRepoImpl(remoteDataSource: getIt()),
  );

  getIt.registerFactory<ForgetPasswordUseCase>(
    () => ForgetPasswordUseCase(forgetPasswordRepo: getIt()),
  );

  getIt.registerFactory<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(forgetPasswordRepo: getIt()),
  );

  getIt.registerFactory<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(getIt(), getIt()),
  );
}