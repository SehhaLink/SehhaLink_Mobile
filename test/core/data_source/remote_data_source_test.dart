import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sehhalink/core/data_source/remote_data_source.dart';
import 'package:sehhalink/core/networking/api_const.dart';
import 'package:sehhalink/core/networking/network_service.dart';
import 'package:sehhalink/features/auth/login/data/models/login_request_body.dart';
import 'package:sehhalink/features/auth/login/data/models/login_response_body.dart';
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

  group('login', () {
    test('login process will success', () async {
      // Arrange
      final request = LoginRequestBody(
        email: "admin@gmail.com",
        password: "admin1234@",
      );

      final user = LoginResponseBody(
        firstName: 'adel',
        lastName: 'saeed',
        email: 'admin@1234',
        phoneNumber: '01020163',
        country: 'Egypt',
        city: 'Cairo',
        address: 'Helwan',
        role: 'admin',
        loginToken: 'fadsffadfadsfadf',
      );

      final response = Response(
        requestOptions: RequestOptions(path: ApiConst.login),
        statusCode: 200,
        data: user.toJson(),
      );

      when(
        mockNetworkService.post(ApiConst.login, any),
      ).thenAnswer((_) async => response);

      // Act
      final result = await remoteDataSource.login(request);

      // Assert
      expect(result.toJson(), user.toJson());
    });

    test('Login process will failed', () async {
      // arrange
      final request = LoginRequestBody(
        email: "admin@gmail.com",
        password: "admin1234@",
      );
      final response = Response(
        requestOptions: RequestOptions(path: ApiConst.login),
        statusCode: 401,
        data: {"message": "Unauthorized"},
      );

      when(
        mockNetworkService.post(ApiConst.login, any),
      ).thenAnswer((_) async => response);

      expect(() => remoteDataSource.login(request), throwsException);
    });
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

      when(
        mockNetworkService.post(ApiConst.register, any),
      ).thenAnswer((_) async => mockResponse);

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

      when(
        mockNetworkService.post(ApiConst.register, any),
      ).thenAnswer((_) async => mockResponse);

      final result = await remoteDataSource.register(request);

      expect(result, false);
    });
  });
}
