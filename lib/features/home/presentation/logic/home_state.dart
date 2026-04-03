import 'package:sehhalink/features/home/domain/entities/upload_file_item.dart';

class HomeState {
  final List<UploadedFileItem> files;
  final bool isDragging;
  final bool isPickingFile;
  final String? errorMessage;
  final DateTime? lastUploadTime;
  final int savedFilesCount;
  final bool isGeneralSummaryLoading;
  final String? generalSummary;

  const HomeState({
    this.files = const [],
    this.isDragging = false,
    this.isPickingFile = false,
    this.errorMessage,
    this.lastUploadTime,
    this.savedFilesCount = 0,
    this.generalSummary,
    this.isGeneralSummaryLoading = false,
  });

  int get doneCount => savedFilesCount;

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
    int? savedFilesCount,
    String? generalSummary,
    bool? isGeneralSummaryLoading,
  }) {
    return HomeState(
      files: files ?? this.files,
      isDragging: isDragging ?? this.isDragging,
      isPickingFile: isPickingFile ?? this.isPickingFile,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      lastUploadTime: lastUploadTime ?? this.lastUploadTime,
      savedFilesCount: savedFilesCount ?? this.savedFilesCount,
      generalSummary: generalSummary ?? this.generalSummary,
      isGeneralSummaryLoading:
          isGeneralSummaryLoading ?? this.isGeneralSummaryLoading,
    );
  }
}
