import 'dart:io';

abstract class HomeRepo {
  Future<void> uploadFile(File file);
}
