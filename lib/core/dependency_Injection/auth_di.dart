import 'package:sehhalink/core/data_source/user_local_data_source.dart';
import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/core/networking/network_service.dart';
import 'package:sehhalink/core/utils/register_lazy_if_not_registered.dart';
import 'package:sehhalink/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:sehhalink/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:sehhalink/features/auth/domain/repo/auth_repo.dart';
import 'package:sehhalink/features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:sehhalink/features/auth/domain/use_cases/login_use_case.dart';
import 'package:sehhalink/features/auth/domain/use_cases/register_use_case.dart';
import 'package:sehhalink/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:sehhalink/features/auth/presentation/logic/auth_cubit.dart';

void authDi() {
  if (getIt.isRegistered<AuthCubit>()) {
    return;
  }
  registerLazyIfNotRegistered<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(networkService: getIt<NetworkService>()),
  );

  registerLazyIfNotRegistered<AuthRepo>(
    () => AuthRepoImpl(
      authRemoteDataSource: getIt<AuthRemoteDataSource>(),
      userLocalDataSource: getIt<UserLocalDataSource>(),
    ),
  );

  registerLazyIfNotRegistered<LoginUseCase>(
    () => LoginUseCase(authRepo: getIt()),
  );

  registerLazyIfNotRegistered<ForgetPasswordUseCase>(
    () => ForgetPasswordUseCase(authRepo: getIt()),
  );

  registerLazyIfNotRegistered<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(authRepo: getIt()),
  );

  registerLazyIfNotRegistered<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepo>()),
  );

  registerLazyIfNotRegistered<AuthCubit>(
    () => AuthCubit(
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
      forgetPasswordUseCase: getIt<ForgetPasswordUseCase>(),
      resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
    ),
  );
}
