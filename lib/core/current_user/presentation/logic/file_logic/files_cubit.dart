import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/add_file_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/delete_file_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/get_all_files_use_case.dart';
import 'package:sehhalink/core/current_user/domain/use_cases/get_file_summary_use_case.dart';
import 'files_state.dart';

class FilesCubit extends Cubit<FilesState> {
  final GetUserFilesUseCase _getUserFilesUseCase;
  final AddFileUseCase _addFileUseCase;
  final DeleteFileUseCase _deleteFileUseCase;
  final GetFileSummaryUseCase _getFileSummaryUseCase;

  FilesCubit({
    required GetUserFilesUseCase getUserFilesUseCase,
    required AddFileUseCase addFileUseCase,
    required DeleteFileUseCase deleteFileUseCase,
    required GetFileSummaryUseCase getFileSummaryUseCase,
  }) : _getUserFilesUseCase = getUserFilesUseCase,
       _addFileUseCase = addFileUseCase,
       _deleteFileUseCase = deleteFileUseCase,
       _getFileSummaryUseCase = getFileSummaryUseCase,
       super(const FilesState());

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
      await loadFiles();
    } catch (e) {
      emit(state.copyWith(error: 'Failed to add file: $e'));
    }
  }

  Future<void> deleteFile(String fileId) async {
    try {
      await _deleteFileUseCase(fileId);
      await loadFiles();
    } catch (e) {
      emit(state.copyWith(error: 'Failed to delete file: $e'));
    }
  }

  Future<void> summarizeFile(String fileId) async {
    emit(
      state.copyWith(
        loadingSummaries: {...state.loadingSummaries, fileId},
        error: null,
      ),
    );

    final result = await _getFileSummaryUseCase(fileId);

    result.when(
      onSuccess: (_) async {
        final files = await _getUserFilesUseCase();
        final updated = Set<String>.from(state.loadingSummaries)
          ..remove(fileId);
        emit(state.copyWith(files: files, loadingSummaries: updated));
      },
      onError: (error) {
        final updated = Set<String>.from(state.loadingSummaries)
          ..remove(fileId);
        emit(state.copyWith(loadingSummaries: updated, error: error.message));
      },
    );
  }

  Future<void> clearFiles() async {
    emit(const FilesState());
  }
}
