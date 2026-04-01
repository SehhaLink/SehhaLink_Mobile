enum UploadStatus { uploading, done, failed }

class UploadedFileItem {
  final String name;
  final String size;
  final double progress;
  final UploadStatus status;
  final DateTime? uploadedAt; 
  final String? fileId;

  const UploadedFileItem({
    required this.name,
    required this.size,
    required this.progress,
    required this.status,
    this.uploadedAt,
    this.fileId,
  });

  UploadedFileItem copyWith({
    String? name,
    String? size,
    double? progress,
    UploadStatus? status,
    DateTime? uploadedAt,
    String? fileId,
  }) {
    return UploadedFileItem(
      name: name ?? this.name,
      size: size ?? this.size,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      fileId: fileId ?? this.fileId,
    );
  }
}