
import 'package:sehhalink/core/dependency_Injection/get_it.dart';

void registerLazyIfNotRegistered<T extends Object>(T Function() factory) {
  if (!getIt.isRegistered<T>()) {
    getIt.registerLazySingleton<T>(factory);
  }
}
