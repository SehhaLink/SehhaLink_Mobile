import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/get_current_user_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/logout_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/update_current_user.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/update_profile_image_use_case.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_logic/current_user_state.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final UpdateCurrentUserUseCase _updateUserUseCase;
  final UpdateProfileImageUseCase _updateProfileImageUseCase;
  final LogoutUseCase _logoutUseCase;

  CurrentUserCubit({
    required LogoutUseCase logoutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required UpdateCurrentUserUseCase updateUserUseCase,
    required UpdateProfileImageUseCase updateProfileImageUseCase,
  }) : _getCurrentUserUseCase = getCurrentUserUseCase,
       _updateUserUseCase = updateUserUseCase,
       _updateProfileImageUseCase = updateProfileImageUseCase,
       _logoutUseCase = logoutUseCase,
       super(const CurrentUserState());

  Future<void> loadUser() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final user = await _getCurrentUserUseCase();
      emit(state.copyWith(user: user, isLoading: false));
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

  Future<void> updateProfileImage(File imageFile) async {
    if (state.user == null) {
      emit(state.copyWith(error: 'No user loaded'));
      return;
    }
    emit(state.copyWith(isUpdatingImage: true, error: null));
    try {
      await _updateProfileImageUseCase(imageFile);
      final updatedUser = await _getCurrentUserUseCase();
      emit(state.copyWith(user: updatedUser, isUpdatingImage: false));
    } catch (e) {
      emit(
        state.copyWith(
          isUpdatingImage: false,
          error: 'Failed to update image: $e',
        ),
      );
    }
  }

 Future<void> logout() async {
  try {
    await _logoutUseCase();
    emit(const CurrentUserState());
  } catch (e) {
    emit(state.copyWith(error: 'Failed to logout: $e'));
  }
}

  User? get currentUser => state.user;
}
