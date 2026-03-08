
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sehhalink/core/data_source/remote_data_source.dart';
import 'package:sehhalink/core/networking/api_const.dart';
import 'package:sehhalink/core/networking/network_service.dart';
import 'package:sehhalink/features/auth/register/data/models/register_request_body.dart';

import 'remote_data_source_test.mocks.dart';

@GenerateMocks([NetworkService])
void main() {
  late final RemoteDataSourceImpl remoteDataSource;
  late final NetworkService mockNetworkService;

  setUp(() {
    mockNetworkService = MockNetworkService();
    remoteDataSource = RemoteDataSourceImpl(mockNetworkService);
  });

  group('Signup', () {
    test('Sign up process succeeds', () async {
      final request = RegisterRequestBody(
        email: "admin@gmail.com",
        phoneNumber: "01020237163",
        password: "adel1234@",
        fullName: "Adel saeed",
      );

      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiConst.register),
        statusCode: 200,
        data: {"isSuccess": true},
      );

      when(mockNetworkService.post(ApiConst.register, any))
          .thenAnswer((_) async => mockResponse);

      final result = await remoteDataSource.register(request);

      expect(result, true);
    });

    test('Sign up process fails', () async {
      final request = RegisterRequestBody(
        email: "admin@gmail.com",
        phoneNumber: "01020237163",
        password: "adel1234@",
        fullName: "Adel saeed",
      );

      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiConst.register),
        statusCode: 400,
        data: {"isSuccess": false}, 
      );

      when(mockNetworkService.post(ApiConst.register, any))
          .thenAnswer((_) async => mockResponse);

      final result = await remoteDataSource.register(request);

      expect(result, false);
    });
  });
}