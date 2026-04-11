import 'package:sehhalink/core/current_user/domain/entity/user_file.dart';
import 'package:sehhalink/core/networking/api_result.dart';

abstract class FileRepo {
  Future<void> addFile(UserFile file);
  Future<List<UserFile>> getUserFiles();
  Future<void> deleteFile(String fileId);
  Future<ApiResult<String>> summarizeFile(String fileId);
}
