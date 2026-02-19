import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/core/utils/register_lazy_if_not_registered.dart';
import 'package:sehhalink/features/auth/register/data/repo_impl/register_repo_impl.dart';
import 'package:sehhalink/features/auth/register/domain/repo/register_repo.dart';
import 'package:sehhalink/features/auth/register/domain/use_cse/register_use_case.dart';
import 'package:sehhalink/features/auth/register/presentation/logic/register_cubit.dart';

void registerScreenDi() {
  if (getIt.isRegistered<RegisterCubit>()) return;

  registerLazyIfNotRegistered<RegisterRepo>(() => RegisterRepoImpl(getIt()));

  registerLazyIfNotRegistered<RegisterUseCase>(
    () => RegisterUseCase(getIt<RegisterRepo>()),
  );

  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
}
