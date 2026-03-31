import 'package:isar/isar.dart';
import 'package:sehhalink/core/current_user/data/model/user_model.dart';
import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';
part 'file_model.g.dart';
@Collection()
class FileModel {
  Id id = Isar.autoIncrement;
  late String fileId;
  late String fileName;
  late String filePath;
  late String summary;
  late String fileType;
  late String createdAt;

  @Backlink(to: 'files')
  final user = IsarLink<UserModel>();

  UserFile toEntity() {
    return UserFile(
      fileId: fileId,
      fileName: fileName,
      filePath: filePath,
      summary: summary,
      fileType: fileType,
      createdAt: createdAt,
    );
  }

  static FileModel fromEntity(UserFile file) {
    return FileModel()
      ..fileId = file.fileId
      ..fileName = file.fileName
      ..filePath = file.filePath
      ..summary = file.summary
      ..fileType = file.fileType
      ..createdAt = file.createdAt;
  }
}