import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/features/home/domain/entities/upload_file_item.dart';
import 'package:sehhalink/features/home/domain/use_cases/get_saved_files_use_case.dart';
import 'package:sehhalink/features/home/domain/use_cases/get_user_general_summary_use_case.dart';
import 'package:sehhalink/features/home/domain/use_cases/save_file_use_case.dart';
import 'package:sehhalink/features/home/domain/use_cases/upload_file_use_case.dart';
import 'package:sehhalink/features/home/presentation/logic/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.uploadFileUseCase,
    required this.saveFileUseCase,
    required this.getSavedFilesUseCase,
    required this.getUserGeneralSummaryUseCase,
  }) : super(const HomeState());

  final UploadFileUseCase uploadFileUseCase;
  final SaveFileUseCase saveFileUseCase;
  final GetSavedFilesUseCase getSavedFilesUseCase;
  final GetUserGeneralSummaryUseCase getUserGeneralSummaryUseCase;

  Future<void> loadSavedFiles() async {
    try {
      final savedFiles = await getSavedFilesUseCase();
      if (savedFiles.isEmpty) return;

      final items = savedFiles
          .map(
            (f) => UploadedFileItem(
              name: f.fileName,
              size: f.size ?? '',
              progress: 1.0,
              status: UploadStatus.done,
              uploadedAt: f.uploadedAt,
              fileId: f.fileId,
            ),
          )
          .toList();

      final lastUpload = savedFiles
          .where((f) => f.uploadedAt != null)
          .map((f) => f.uploadedAt!)
          .fold<DateTime?>(
            null,
            (prev, curr) => prev == null || curr.isAfter(prev) ? curr : prev,
          );

      emit(
        state.copyWith(
          files: items,
          lastUploadTime: lastUpload,
          savedFilesCount: savedFiles.length,
          isLoading: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> loadGeneralSummary() async {
    emit(state.copyWith(isGeneralSummaryLoading: true));
    final summary = await getUserGeneralSummaryUseCase();
    if (isClosed) return;
    summary.when(
      onSuccess: (data) => emit(
        state.copyWith(generalSummary: data, isGeneralSummaryLoading: false),
      ),
      onError: (error) => emit(
        state.copyWith(
          errorMessage: error.message,
          isGeneralSummaryLoading: false,
        ),
      ),
    );
  }

  Future<void> pickAndUpload() async {
    emit(state.copyWith(isPickingFile: true, clearError: true));
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'dcm'],
    );
    emit(state.copyWith(isPickingFile: false));
    if (result == null || result.files.isEmpty) return;

    final startIndex = state.files.length;
    final newItems = result.files
        .map(
          (p) => UploadedFileItem(
            name: p.name,
            size: _formatSize(p.size),
            progress: 0.0,
            status: UploadStatus.uploading,
            uploadedAt: DateTime.now(),
          ),
        )
        .toList();

    emit(state.copyWith(files: [...state.files, ...newItems]));

    final futures = <Future>[];
    for (int i = 0; i < result.files.length; i++) {
      final picked = result.files[i];
      final globalIndex = startIndex + i;
      if (picked.path == null) {
        _markFailed(globalIndex, 'home.file_path_unavailable');
        continue;
      }
      futures.add(_uploadSingle(File(picked.path!), globalIndex));
    }
    await Future.wait(futures);
  }

  Future<void> _uploadSingle(File file, int index) async {
    final result = await uploadFileUseCase(
      file,
      onProgress: (progress) => _updateFile(
        index,
        progress: progress,
        status: UploadStatus.uploading,
      ),
    );

    result.when(
      onSuccess: (fileModel) async {
        final now = DateTime.now();
        fileModel.uploadedAt = now;

        _updateFile(
          index,
          progress: 1.0,
          status: UploadStatus.done,
          uploadedAt: now,
          fileId: fileModel.fileId,
        );

        await saveFileUseCase(fileModel);

        if (isClosed) return;
        final updated = state.files
            .map((f) {
              if (f.fileId == fileModel.fileId) {
                return f.copyWith(isStored: true);
              }
              return f;
            })
            .where((f) => !f.isStored)
            .toList();

        emit(
          state.copyWith(
            files: updated,
            lastUploadTime: now,
            savedFilesCount: state.savedFilesCount + 1,
            clearGeneralSummary: true,
          ),
        );
      },
      onError: (error) {
        _markFailed(index, error.message);
      },
    );
  }

  Future<void> retryUpload(int index) async {
    final file = state.files[index];
    if (file.fileId == null) {
      cancelUpload(index);
      return;
    }

    _updateFile(index, progress: 0.0, status: UploadStatus.uploading);
    emit(state.copyWith(clearError: true));
  }

  void removeFile(int index) {
    final updated = List<UploadedFileItem>.from(state.files)..removeAt(index);
    emit(state.copyWith(files: updated));
  }

  void cancelUpload(int index) {
    final updated = List<UploadedFileItem>.from(state.files)..removeAt(index);
    emit(state.copyWith(files: updated));
  }

  void onDragEnter() => emit(state.copyWith(isDragging: true));
  void onDragExit() => emit(state.copyWith(isDragging: false));

  void _updateFile(
    int index, {
    double? progress,
    UploadStatus? status,
    DateTime? uploadedAt,
    String? fileId,
  }) {
    if (isClosed) return;
    if (index < 0 || index >= state.files.length) return;

    final updated = List<UploadedFileItem>.from(state.files);
    updated[index] = updated[index].copyWith(
      progress: progress,
      status: status,
      uploadedAt: uploadedAt,
      fileId: fileId,
    );
    emit(state.copyWith(files: updated));
  }

  void _markFailed(int index, String error) {
    _updateFile(index, status: UploadStatus.failed);
    emit(state.copyWith(errorMessage: error));
  }

  String _formatSize(int bytes) {
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
