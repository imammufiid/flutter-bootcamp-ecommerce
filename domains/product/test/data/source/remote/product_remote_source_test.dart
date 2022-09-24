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

  test('''Success \n
    GIVEN fetch data product category from API with 200 status code
    WHEN getProductCategories method execute
    THEN return List<ProductCategoryResponseDTO>
  ''', () async {
    final responseJson =
        TestHelper.readJson('helper/json/product_categories.json');
    final httpResponse =
        ResponseBody.fromString(responseJson, HttpStatus.ok, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    });

    when(() => dioAdapterMock.fetch(any(), any(), any()))
        .thenAnswer((_) async => httpResponse);

    final result = await productRemoteSource.getProductCategories();
    expect(result.data!.length, 6);
  });

  test('''Fail \n
    GIVEN fetch data product category with 500 status code
    WHEN getProductCategories method execute
    THEN return throwException  
  ''', () async {
    when(() => dioAdapterMock.fetch(any(), any(), any())).thenThrow(
        const FailureResponse(errorMessage: "internal server error"));

    expect(() => productRemoteSource.getProductCategories(), throwsException);
  });

  test('''Success \n
    GIVEN fetch data product category from API with 200 status code
    WHEN getProducts method execute
    THEN return List<ProductResponseDTO>
  ''', () async {
    final responseJson = TestHelper.readJson('helper/json/products.json');
    final httpResponse =
        ResponseBody.fromString(responseJson, HttpStatus.ok, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    });

    when(() => dioAdapterMock.fetch(any(), any(), any()))
        .thenAnswer((_) async => httpResponse);

    final result = await productRemoteSource.getProducts();
    expect(result.data?.countPerPage, 4);
    expect(result.data?.data?.length, 4);
  });

  test('''Fail \n
    GIVEN fetch data product category with 500 status code
    WHEN getProducts method execute
    THEN return throwException  
  ''', () async {
    when(() => dioAdapterMock.fetch(any(), any(), any())).thenThrow(
        const FailureResponse(errorMessage: "internal server error"));

    expect(() => productRemoteSource.getProducts(), throwsException);
  });

  test('''Success \t
    GIVEN fetch data product detail from API with 200 status code
    WHEN getProductDetail(id) method execute
    THEN return ProductDetailResponseDto
  ''', () async {
    final responseJson = TestHelper.readJson('helper/json/product_detail.json');
    final httpResponse =
        ResponseBody.fromString(responseJson, HttpStatus.ok, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    });
    when(() => dioAdapterMock.fetch(any(), any(), any()))
        .thenAnswer((_) async => httpResponse);

    final result = await productRemoteSource.getProductDetail("1");
    expect(result.data?.name, "Meja Antik");
  });

  test('''Fail \n
    GIVEN fetch data product detail with 500 status code
    WHEN getProductDetail(id) method execute
    THEN return throwException  
  ''', () async {
    when(() => dioAdapterMock.fetch(any(), any(), any())).thenThrow(
        const FailureResponse(errorMessage: "internal server error"));

    expect(() => productRemoteSource.getProductDetail("1"), throwsException);
  });

  test('''Success \t
    GIVEN fetch data seller from API with 200 status code
    WHEN getSeller(id) method execute
    THEN return ProductDetailResponseDto
  ''', () async {
    final responseJson = TestHelper.readJson('helper/json/seller.json');
    final httpResponse =
        ResponseBody.fromString(responseJson, HttpStatus.ok, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    });
    when(() => dioAdapterMock.fetch(any(), any(), any()))
        .thenAnswer((_) async => httpResponse);

    final result = await productRemoteSource.getSeller("1");
    expect(result.data?.username, "parjo_store");
  });

  test('''Fail \n
    GIVEN fetch data seller with 500 status code
    WHEN getSeller(id) method execute
    THEN return throwException  
  ''', () async {
    when(() => dioAdapterMock.fetch(any(), any(), any())).thenThrow(
        const FailureResponse(errorMessage: "internal server error"));

    expect(() => productRemoteSource.getSeller("1"), throwsException);
  });
}
