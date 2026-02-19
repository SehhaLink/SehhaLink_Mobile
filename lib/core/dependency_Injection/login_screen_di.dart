import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/core/utils/register_lazy_if_not_registered.dart';
import 'package:sehhalink/features/auth/login/data/repo_impl/login_repo_impl.dart';
import 'package:sehhalink/features/auth/login/domain/repos/login_repo.dart';
import 'package:sehhalink/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:sehhalink/features/auth/login/presentation/logic/login_cubit.dart';

void loginScreenDi() {
  if (getIt.isRegistered<LoginCubit>()) return;

  registerLazyIfNotRegistered<LoginRepo>(
    () => LoginRepoImpl(remoteDataSource: getIt()),
  );
  registerLazyIfNotRegistered<LoginUseCase>(
    () => LoginUseCase(loginRepo: getIt<LoginRepo>()),
  );

  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
}
