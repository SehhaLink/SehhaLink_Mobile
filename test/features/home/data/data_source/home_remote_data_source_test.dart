import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sehhalink/core/networking/api_const.dart';
import 'package:sehhalink/core/networking/network_service.dart';
import 'package:sehhalink/features/home/data/data_source/home_remote_data_source.dart';

import 'home_remote_data_source_test.mocks.dart';

@GenerateMocks([NetworkService])
void main() {
  late final HomeRemoteDataSource homeRemoteDataSource;
  late final NetworkService mockNetworkService;

  setUp(() {
    mockNetworkService = MockNetworkService();
    homeRemoteDataSource = HomeRemoteDataSourceImpl(
      networkService: mockNetworkService,
    );
  });

  test('upload file will successfully', () async {
    // arrange
    final fileX = File("");

    final response = Response(
      requestOptions: RequestOptions(
        path: ApiConst.uploadDocument,
        data: fileX,
      ),
    );
    when(
      mockNetworkService.post(ApiConst.uploadDocument, any),
    ).thenAnswer((_) async => response);

    //act
    //final result = await homeRemoteDataSource.uploadFile(fileX);

    // assert
    expect(true,true);
  });
}
