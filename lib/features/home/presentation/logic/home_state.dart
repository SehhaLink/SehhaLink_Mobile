import 'package:equatable/equatable.dart';
import 'package:sehhalink/features/home/domain/entities/upload_file_item.dart';

class HomeState extends Equatable {
  final List<UploadedFileItem> files;
  final bool isPickingFile;
  final bool isDragging;
  final String? errorMessage;

  const HomeState({
    this.files = const [],
    this.isPickingFile = false,
    this.isDragging = false,
    this.errorMessage,
  });

  int get totalFiles => files.length;

  bool get hasFiles => files.isNotEmpty;

  int get doneCount => files.where((f) => f.status == UploadStatus.done).length;

  int get uploadingCount =>
      files.where((f) => f.status == UploadStatus.uploading).length;

  int get failedCount =>
      files.where((f) => f.status == UploadStatus.failed).length;

  String? get lastUploadLabel {
    if (files.isEmpty) return null;
    final last = files.last.uploadedAt;
    if (last == null) return null;
    final now = DateTime.now();
    final diff = DateTime(now.year, now.month, now.day)
        .difference(DateTime(last.year, last.month, last.day))
        .inDays;
    if (diff == 0) return 'home.today';
    if (diff == 1) return 'home.yesterday';
    return '${last.day}/${last.month}/${last.year}';
  }

  // ── copyWith ──────────────────────────────────────────────────────────────
  HomeState copyWith({
    List<UploadedFileItem>? files,
    bool? isPickingFile,
    bool? isDragging,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HomeState(
      files: files ?? this.files,
      isPickingFile: isPickingFile ?? this.isPickingFile,
      isDragging: isDragging ?? this.isDragging,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [files, isPickingFile, isDragging, errorMessage];
}