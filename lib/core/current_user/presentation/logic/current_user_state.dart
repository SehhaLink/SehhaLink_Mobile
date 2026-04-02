import 'package:equatable/equatable.dart';
import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';

class CurrentUserState extends Equatable {
  final User? user;
  final List<UserFile> files;
  final bool isLoading;
  final bool isUpdating;
  final bool isUpdatingImage; 
  final bool isLoadingFiles;
  final String? error;
  final Set<String> loadingSummaries; 

  const CurrentUserState({
    this.user,
    this.files = const [],
    this.isLoading = false,
    this.isUpdating = false,
    this.isUpdatingImage = false,
    this.isLoadingFiles = false,
    this.error,
      this.loadingSummaries = const {},
  });

  CurrentUserState copyWith({
    User? user,
    List<UserFile>? files,
    bool? isLoading,
    bool? isUpdating,
    bool? isUpdatingImage,
    bool? isLoadingFiles,
    String? error,
      Set<String>? loadingSummaries,
  }) {
    return CurrentUserState(
      user: user ?? this.user,
      files: files ?? this.files,
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      isUpdatingImage: isUpdatingImage ?? this.isUpdatingImage, 
      isLoadingFiles: isLoadingFiles ?? this.isLoadingFiles,
      error: error,
          loadingSummaries: loadingSummaries ?? this.loadingSummaries,
    );
  }

  @override
  List<Object?> get props => [
        user,
        files,
        isLoading,
        isUpdating,
        isUpdatingImage, 
        isLoadingFiles,
        error,
        loadingSummaries
      ];
}