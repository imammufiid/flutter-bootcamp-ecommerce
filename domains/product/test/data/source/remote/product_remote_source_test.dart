import 'dart:io';

import 'package:common/utils/error/failure_response.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product/data/source/remote/product_remote_source.dart';

import '../../../json_reader.dart';

void main() => testProductRemoteSourceTest();

/// Mocking DioAdapter
class DioAdapterMock extends Mock implements HttpClientAdapter {}

class RequestOptionMock extends Mock implements RequestOptions {}

void testProductRemoteSourceTest() {
  final Dio dio = Dio();
  late DioAdapterMock dioAdapterMock;
  late final ProductRemoteSource productRemoteSource;

  setUpAll(() {
    dioAdapterMock = DioAdapterMock();
    dio.httpClientAdapter = dioAdapterMock;
    productRemoteSource = ProductRemoteSourceImpl(dio: dio);
    registerFallbackValue(RequestOptionMock());
  });

  test('''Success \n
    GIVEN fetch data from API with 200 status code
    WHEN getBanner method execute
    THEN return List<BannerDataDTO>
  ''', () async {
    final responseJson = TestHelper.readJson('helper/json/banner.json');
    final httpResponse =
        ResponseBody.fromString(responseJson, HttpStatus.ok, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType]
    });

    when(() => dioAdapterMock.fetch(any(), any(), any()))
        .thenAnswer((invocation) async => httpResponse);

    final result = await productRemoteSource.getBanners();

    expect(result.data!.length, 1);
  });

  test('''Fail \n
    GIVEN fetch data from API with 500 status code
    WHEN getBanner method execute
    THEN return throwException
  ''', () async {
    when(() => dioAdapterMock.fetch(any(), any(), any())).thenThrow(
        const FailureResponse(errorMessage: "internal server error"));

    expect(() => productRemoteSource.getBanners(), throwsException);
  });
}
