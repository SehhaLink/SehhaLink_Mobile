import 'package:sehhalink/features/home/domain/entities/upload_file_item.dart';

class HomeState {
  final List<UploadedFileItem> files;
  final bool isDragging;
  final bool isPickingFile;
  final String? errorMessage;
  final DateTime? lastUploadTime;

  const HomeState({
    this.files = const [],
    this.isDragging = false,
    this.isPickingFile = false,
    this.errorMessage,
    this.lastUploadTime,
  });

  int get doneCount => files.where((f) => f.status == UploadStatus.done).length;

  String? get lastUploadLabel {
    if (lastUploadTime == null) return null;
    final now = DateTime.now();
    final diff = now.difference(lastUploadTime!);
    if (diff.inDays == 0) return 'home.today';
    if (diff.inDays == 1) return 'home.yesterday';
    return '${lastUploadTime!.day}/${lastUploadTime!.month}/${lastUploadTime!.year}';
  }

  bool get hasFiles => files.isNotEmpty;

  HomeState copyWith({
    List<UploadedFileItem>? files,
    bool? isDragging,
    bool? isPickingFile,
    String? errorMessage,
    bool clearError = false,
    DateTime? lastUploadTime,
  }) {
    return HomeState(
      files: files ?? this.files,
      isDragging: isDragging ?? this.isDragging,
      isPickingFile: isPickingFile ?? this.isPickingFile,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      lastUploadTime: lastUploadTime ?? this.lastUploadTime,
    );
  }
}
