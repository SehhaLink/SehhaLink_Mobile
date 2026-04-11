import 'package:sehhalink/core/networking/api_const.dart';
import 'package:sehhalink/core/networking/network_service.dart';

abstract class FileRemoteDataSource {
  Future<String> summarizeFile(String fileId);
}

class FileRemoteDataSourceImpl extends FileRemoteDataSource {
  final NetworkService networkService;
  FileRemoteDataSourceImpl({required this.networkService});

  @override
  Future<String> summarizeFile(String fileId) async {
    final response = await networkService.postEmpty(
      ApiConst.summarize(int.parse(fileId)),
    );
    if (response.statusCode != 200 || response.data['success'] != true) {
      throw Exception('Summarize failed');
    }
    return response.data['data']['summary'] as String;
  }
}