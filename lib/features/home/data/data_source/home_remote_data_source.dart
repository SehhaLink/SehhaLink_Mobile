import 'dart:io';

abstract class HomeRemoteDataSource {
  Future<void> uploadFile(File file);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  @override
  Future<void> uploadFile(File file) {
    //TODO  solve it
    throw UnimplementedError();
  }
}
