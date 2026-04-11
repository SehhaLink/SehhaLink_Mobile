import 'package:sehhalink/core/current_user/domain/repo/current_user_repository.dart';

class LogoutUseCase {
  final CurrentUserRepository repository;
  LogoutUseCase(this.repository);
  Future<void> call() async => await repository.logout();
}