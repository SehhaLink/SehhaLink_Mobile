import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/get_current_user_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/update_current_user.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_state.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final UpdateCurrentUserUseCase _updateUserUseCase;

  CurrentUserCubit({
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required UpdateCurrentUserUseCase updateUserUseCase,
  }) : _getCurrentUserUseCase = getCurrentUserUseCase,
       _updateUserUseCase = updateUserUseCase,
       super(const CurrentUserState());

  Future<void> loadUser() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final user = await _getCurrentUserUseCase();

      emit(state.copyWith(user: user, isLoading: false, error: null));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Failed to load user: $e'));
    }
  }

  Future<void> updateUser({required User user}) async {
    if (state.user == null) {
      emit(state.copyWith(error: 'No user loaded'));
      return;
    }

    emit(state.copyWith(isUpdating: true, error: null));

    try {
      await _updateUserUseCase(user);

      emit(state.copyWith(user: user, isUpdating: false));
    } catch (e) {
      emit(
        state.copyWith(isUpdating: false, error: 'Failed to update user: $e'),
      );
    }
  }

  User? get currentUser => state.user;
}
