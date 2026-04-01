import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/add_file_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/delete_file_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/get_all_files_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/get_current_user_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/update_current_user.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/update_profile_image_use_case.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_state.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final UpdateCurrentUserUseCase _updateUserUseCase;
  final AddFileUseCase _addFileUseCase;
  final GetUserFilesUseCase _getUserFilesUseCase;
  final DeleteFileUseCase _deleteFileUseCase;
final UpdateProfileImageUseCase _updateProfileImageUseCase;
  CurrentUserCubit({
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required UpdateCurrentUserUseCase updateUserUseCase,
    required AddFileUseCase addFileUseCase,
    required GetUserFilesUseCase getUserFilesUseCase,
    required DeleteFileUseCase deleteFileUseCase, required UpdateProfileImageUseCase updateProfileImageUseCase,
  }) : _updateProfileImageUseCase = updateProfileImageUseCase, _getCurrentUserUseCase = getCurrentUserUseCase,
       _updateUserUseCase = updateUserUseCase,
       _addFileUseCase = addFileUseCase,
       _getUserFilesUseCase = getUserFilesUseCase,
       _deleteFileUseCase = deleteFileUseCase,
       super(const CurrentUserState());

  Future<void> loadFiles() async {
    emit(state.copyWith(isLoadingFiles: true, error: null));
    try {
      final files = await _getUserFilesUseCase();
      emit(state.copyWith(files: files, isLoadingFiles: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingFiles: false,
          error: 'Failed to load files: $e',
        ),
      );
    }
  }

  Future<void> addFile(UserFile file) async {
    try {
      await _addFileUseCase(file);
      await loadFiles(); // refresh
    } catch (e) {
      emit(state.copyWith(error: 'Failed to add file: $e'));
    }
  }



  Future<void> deleteFile(String fileId) async {
    try {
      await _deleteFileUseCase(fileId);
      await loadFiles(); // refresh
    } catch (e) {
      emit(state.copyWith(error: 'Failed to delete file: $e'));
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
    emit(state.copyWith(
      isUpdatingImage: false,
      error: 'Failed to update image: $e',
    ));
  }
}

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
