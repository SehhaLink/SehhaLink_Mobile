class UserFile {
  final String fileId;
  final String fileName;
  final String filePath;
  final String? summary;
  final String fileType;
  final String createdAt;

  UserFile({
    required this.fileId,
    required this.fileName,
    required this.filePath,
    required this.summary,
    required this.fileType,
    required this.createdAt,
  });
}