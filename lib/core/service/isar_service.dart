import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sehhalink/core/current_user/data/model/file_model.dart';
import 'package:sehhalink/core/current_user/data/model/user_model.dart';

class IsarService {
  static Isar? _isar;

  static Future<Isar> get instance async {
    _isar ??= await _init();
    return _isar!;
  }

  static Future<Isar> _init() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [UserModelSchema, FileModelSchema],
      directory: dir.path,
    );
  }
}