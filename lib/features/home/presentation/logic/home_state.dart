import 'package:sehhalink/features/home/domain/entities/upload_file_item.dart';

class HomeState {
  final List<UploadedFileItem> files;
  final bool isDragging;
  final bool isPickingFile;
  final String? errorMessage;
  final bool isGeneralSummaryLoading;
  final String? generalSummary;
  final bool isLoading;
  final bool clearGeneralSummary;
  final List<UploadedFileItem> uploadingFiles;
    final bool isSummaryFromCache;
  const HomeState({
    this.isLoading = true,
    this.clearGeneralSummary = false,
    this.files = const [],
    this.isDragging = false,
    this.isPickingFile = false,
    this.errorMessage,
    this.generalSummary,
    this.isGeneralSummaryLoading = false,
    this.uploadingFiles = const [],
    this.isSummaryFromCache = false,
  });

  bool get hasFiles => files.isNotEmpty;

  HomeState copyWith({
    List<UploadedFileItem>? files,
    bool? isDragging,
    bool? isPickingFile,
    String? errorMessage,
    bool clearError = false,
    String? generalSummary,
    bool? isGeneralSummaryLoading,
    bool? isLoading,
    bool? clearGeneralSummary,
    List<UploadedFileItem>? uploadingFiles,
    bool? isSummaryFromCache,
  }) {
    return HomeState(
      clearGeneralSummary: clearGeneralSummary ?? this.clearGeneralSummary,
      files: files ?? this.files,
      isDragging: isDragging ?? this.isDragging,
      isPickingFile: isPickingFile ?? this.isPickingFile,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      generalSummary: generalSummary ?? this.generalSummary,
      isGeneralSummaryLoading:
          isGeneralSummaryLoading ?? this.isGeneralSummaryLoading,
      isLoading: isLoading ?? this.isLoading,
      uploadingFiles: uploadingFiles ?? this.uploadingFiles,
      isSummaryFromCache: isSummaryFromCache??this.isSummaryFromCache
    );
  }
}
