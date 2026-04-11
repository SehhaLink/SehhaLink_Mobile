import 'package:equatable/equatable.dart';
import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';

class FilesState extends Equatable {
  final List<UserFile> files;
  final bool isLoadingFiles;
  final Set<String> loadingSummaries;
  final String? error;

  const FilesState({
    this.files = const [],
    this.isLoadingFiles = false,
    this.loadingSummaries = const {},
    this.error,
  });

  FilesState copyWith({
    List<UserFile>? files,
    bool? isLoadingFiles,
    Set<String>? loadingSummaries,
    String? error,
  }) {
    return FilesState(
      files: files ?? this.files,
      isLoadingFiles: isLoadingFiles ?? this.isLoadingFiles,
      loadingSummaries: loadingSummaries ?? this.loadingSummaries,
      error: error,
    );
  }

  @override
  List<Object?> get props => [files, isLoadingFiles, loadingSummaries, error];
}