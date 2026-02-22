import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/features/home/presentation/logic/home_cubit.dart';

void homeScreenDi() {
  if (getIt.isRegistered<HomeCubit>()) {
    return;
  }
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
}
