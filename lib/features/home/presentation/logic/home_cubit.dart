import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/features/home/domain/entities/upload_file_item.dart';
import 'package:sehhalink/features/home/domain/use_cases/save_file_use_case.dart';
import 'package:sehhalink/features/home/domain/use_cases/upload_file_use_case.dart';
import 'package:sehhalink/features/home/presentation/logic/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.uploadFileUseCase, required this.saveFileUseCase})
    : super(const HomeState());

  final UploadFileUseCase uploadFileUseCase;
  final SaveFileUseCase saveFileUseCase;

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
    final newItems = result.files.map((p) {
      return UploadedFileItem(
        name: p.name,
        size: _formatSize(p.size),
        progress: 0.0,
        status: UploadStatus.uploading,
        uploadedAt: DateTime.now(),
      );
    }).toList();

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
        await saveFileUseCase(fileModel);
        _updateFile(
          index,
          progress: 1.0,
          status: UploadStatus.done,
          uploadedAt: DateTime.now(),
          fileId: fileModel.fileId,
        );
      },
      onError: (error) {
        _markFailed(index, error.message);
      },
    );
  }

  void retryUpload(int index) {
    _updateFile(index, progress: 0.0, status: UploadStatus.uploading);
    emit(state.copyWith(clearError: true));
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
    if (isClosed || index >= state.files.length) return;
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
