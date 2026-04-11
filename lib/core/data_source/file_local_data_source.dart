// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

import 'package:sehhalink/core/current_user/data/model/file_model.dart';
import 'package:sehhalink/core/current_user/data/model/user_model.dart';
import 'package:sehhalink/core/data_source/user_local_data_source.dart';
import 'package:sehhalink/core/service/cache_exception.dart';
import 'package:sehhalink/core/service/isar_service.dart';

abstract class FileLocalDataSource {
  Future<void> addFile(FileModel file);
  Future<List<FileModel>> getUserFiles();
  Future<void> deleteFile(String fileId);
  Future<void> updateFileSummary(String fileId, String summary);
  Future<String?> getCachedSummary(String fileId);
  Future<String?> getCachedGeneralSummary();
  Future<void> saveGeneralSummary(String summary);
}

class FileLocalDataSourceImpl extends FileLocalDataSource {
  final UserLocalDataSource userLocalDataSource;
  FileLocalDataSourceImpl({required this.userLocalDataSource});

  @override
  Future<void> addFile(FileModel file) async {
    try {
      final isar = await IsarService.instance;
      final user = await userLocalDataSource.getCurrentUser();
      await isar.writeTxn(() async {
        await isar.fileModels.put(file);
        user.files.add(file);
        await user.files.save();
      });
    } catch (e) {
      throw CacheException('Failed to add file: $e');
    }
  }

  @override
  Future<void> deleteFile(String fileId) async {
    try {
      final isar = await IsarService.instance;
      await isar.writeTxn(() async {
        final file = await isar.fileModels
            .filter()
            .fileIdEqualTo(fileId)
            .findFirst();
        if (file != null) await isar.fileModels.delete(file.id);
      });
    } catch (e) {
      throw CacheException('Failed to delete file: $e');
    }
  }

  @override
  Future<List<FileModel>> getUserFiles() async {
    try {
      final user = await userLocalDataSource.getCurrentUser();
      await user.files.load();
      return user.files.toList();
    } catch (e) {
      throw CacheException('Failed to get files: $e');
    }
  }

  @override
  Future<String?> getCachedSummary(String fileId) async {
    try {
      final isar = await IsarService.instance;
      final file = await isar.fileModels
          .filter()
          .fileIdEqualTo(fileId)
          .findFirst();
      return file?.summary;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateFileSummary(String fileId, String summary) async {
    try {
      final isar = await IsarService.instance;
      await isar.writeTxn(() async {
        final file = await isar.fileModels
            .filter()
            .fileIdEqualTo(fileId)
            .findFirst();
        if (file != null) {
          file.summary = summary;
          await isar.fileModels.put(file);
        }
      });
    } catch (e) {
      throw CacheException('Failed to update summary: $e');
    }
  }

  @override
  Future<String?> getCachedGeneralSummary() async {
    try {
      final isar = await IsarService.instance;
      final user = await isar.userModels.where().findFirst();
      return user?.generalSummary;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveGeneralSummary(String summary) async {
    try {
      final isar = await IsarService.instance;
      await isar.writeTxn(() async {
        final user = await isar.userModels.where().findFirst();
        if (user != null) {
          user.generalSummary = summary;
          await isar.userModels.put(user);
        }
      });
    } catch (e) {
      throw CacheException('Failed to save general summary: $e');
    }
  }
}
