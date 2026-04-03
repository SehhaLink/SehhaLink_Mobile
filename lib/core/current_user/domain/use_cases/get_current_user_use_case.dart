import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/current_user/domain/repo/current_user_repository.dart';

class GetCurrentUserUseCase {
  final CurrentUserRepository _repository;
  GetCurrentUserUseCase(this._repository);
  Future<User> call() async => await _repository.getCurrentUser();
}