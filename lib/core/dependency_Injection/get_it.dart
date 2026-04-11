import 'package:get_it/get_it.dart';
import 'package:sehhalink/core/data_source/file_local_data_source.dart';
import 'package:sehhalink/core/data_source/remote_data_source.dart';
import 'package:sehhalink/core/data_source/user_local_data_source.dart';
import 'package:sehhalink/core/networking/network_service.dart';
import 'package:sehhalink/core/utils/register_lazy_if_not_registered.dart';

final getIt = GetIt.instance;

void setupDi() {
  getIt.registerLazySingleton<NetworkService>(() => NetworkServiceImp());
  registerLazyIfNotRegistered<RemoteDataSource>(
    () => RemoteDataSourceImpl(getIt<NetworkService>()),
  );
  registerLazyIfNotRegistered<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(),
  );
  registerLazyIfNotRegistered<FileLocalDataSource>(
    () => FileLocalDataSourceImpl(userLocalDataSource: getIt()),
  );

  
}
