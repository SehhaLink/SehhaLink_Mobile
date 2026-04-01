import 'package:dio/dio.dart';
import 'package:sehhalink/core/networking/dio_factory.dart';

abstract class NetworkService {
  Future<Response> get(String url);
  Future<Response> post(
    String url,
    dynamic body, {
    Options? options,                              // ✅ أضفنا options
    void Function(int sent, int total)? onSendProgress,
  });
}

class NetworkServiceImp extends NetworkService {
  final dio = DioFactory.getDio();

  @override
  Future<Response> get(String url) async {
    return await dio.get(url);
  }

  @override
  Future<Response> post(
    String url,
    dynamic body, {
    Options? options,                              // ✅
    void Function(int sent, int total)? onSendProgress,
  }) async {
    return await dio.post(
      url,
      data: body,
      options: options,                           // ✅
      onSendProgress: onSendProgress,
    );
  }
}