import 'package:equatable/equatable.dart';
import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';

class CurrentUserState extends Equatable {
  final User? user;
  final List<UserFile> files; 
  final bool isLoading;
  final bool isUpdating;
  final bool isLoadingFiles; 
  final String? error;

  const CurrentUserState({
    this.user,
    this.files = const [],
    this.isLoading = false,
    this.isUpdating = false,
    this.isLoadingFiles = false,
    this.error,
  });

  CurrentUserState copyWith({
    User? user,
    List<UserFile>? files,
    bool? isLoading,
    bool? isUpdating,
    bool? isLoadingFiles,
    String? error,
  }) {
    return CurrentUserState(
      user: user ?? this.user,
      files: files ?? this.files,
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      isLoadingFiles: isLoadingFiles ?? this.isLoadingFiles,
      error: error,
    );
  }

  @override
  List<Object?> get props => [user, files, isLoading, isUpdating, isLoadingFiles, error];
}