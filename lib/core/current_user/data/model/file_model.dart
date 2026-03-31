import 'package:isar/isar.dart';
import 'package:sehhalink/core/current_user/data/model/user_model.dart';
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
}