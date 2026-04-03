import 'package:dio/dio.dart';
import 'package:sehhalink/core/networking/dio_factory.dart';

abstract class NetworkService {
  Future<Response> get(String url);
  Future<Response> post(
    String url,
    dynamic body, {
    Options? options,
    void Function(int sent, int total)? onSendProgress,
  });
  Future<Response> postEmpty(String url);
  Future<Response> patch(String url, dynamic body);
  Future<Response> delete(String url, dynamic body);
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
    Options? options,
    void Function(int sent, int total)? onSendProgress,
  }) async {
    return await dio.post(
      url,
      data: body,
      options: options,
      onSendProgress: onSendProgress,
    );
  }

  @override
  Future<Response> postEmpty(String url) async {
    return await dio.post(url);
  }

  @override
  Future<Response<dynamic>> delete(String url, body) async {
    return await dio.delete(url, data: body);
  }

  @override
  Future<Response<dynamic>> patch(String url, body) async {
    return await dio.patch(url, data: body);
  }
}
