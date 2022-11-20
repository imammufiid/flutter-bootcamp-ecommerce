import 'package:dependencies/dartz/dartz.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product/data/mapper/product_mapper.dart';
import 'package:product/data/repository/product_repository_impl.dart';
import 'package:product/data/source/local/product_local_source.dart';
import 'package:product/data/source/remote/product_remote_source.dart';
import 'package:product/domain/entity/response/banner_data_entity.dart';
import 'package:product/domain/entity/response/product_category_entity.dart';
import 'package:product/domain/entity/response/product_detail_entity.dart';
import 'package:product/domain/entity/response/product_entity.dart';
import 'package:product/domain/entity/response/seller_data_entity.dart';
import 'package:product/domain/repository/product_repository.dart';

import '../../helper/model/banner_response_dto_dummy.dart';

void main() => testProductRepositoryTest();

class MockProductRemoteSource extends Mock implements ProductRemoteSource {}

class MockProductLocalSource extends Mock implements ProductLocalSource {}

void testProductRepositoryTest() {
  late final ProductRemoteSource _mockProductRemoteSource;
  late final ProductMapper _mockProductMapper;
  late final ProductRepository _productRepository;
  late final ProductLocalSource _mockProductLocalSource;

  setUpAll(() {
    _mockProductRemoteSource = MockProductRemoteSource();
    _mockProductMapper = ProductMapper();
    _mockProductLocalSource = MockProductLocalSource();
    _productRepository = ProductRepositoryImpl(
      remoteSource: _mockProductRemoteSource,
      localSource: _mockProductLocalSource,
      mapper: _mockProductMapper,
    );
  });

  group('Product Repository Impl', () {
    test('''Success \t
      GIVEN Right<BannerResponseDTO> from RemoteDataSource
      WHEN getBanner method execute
      THEN return Right<List<BannerDataEntity>>
    ''', () async {
      when(() => _mockProductRemoteSource.getBanners())
          .thenAnswer((_) async => Future.value(bannerResponseDtoDummy));

      final result = await _productRepository.getBanners();

      expect(result, isA<Right>());
      expect(result.getOrElse(() => []).first, isA<BannerDataEntity>());
      expect(
        result.getOrElse(() => []).first.name,
        bannerResponseDtoDummy?.data?.first.name,
      );
    });

    test('''Fail \t
      GIVEN Right<BannerResponseDTO> from RemoteDataSource
      WHEN getBanner method execute
      THEN return Left<FailureResponse>
    ''', () async {
      when(() => _mockProductRemoteSource.getBanners())
          .thenThrow(DioError(requestOptions: RequestOptions(path: "")));

      final result = await _productRepository.getBanners();

      expect(result, isA<Left>());
    });

    test('''Success \t
      GIVEN Right<ProductCategoryResponseDTO> from RemoteDataSource
      WHEN getProductCategories method execute
      THEN return Right<List<ProductCategoryEntity>>
    ''', () async {
      when(() => _mockProductRemoteSource.getProductCategories()).thenAnswer(
          (invocation) async => Future.value(productCategoryResponseDTODummy));

      final result = await _productRepository.getProductCategories();

      expect(result, isA<Right>());
      expect(result.getOrElse(() => []).first, isA<ProductCategoryEntity>());
      expect(result.getOrElse(() => []).first.name,
          productCategoryResponseDTODummy?.data?.first.name);
    });

    test('''Fail \t
      GIVEN Right<ProductCategoryResponseDTO> from RemoteDataSource
      WHEN getProductCategories method execute
      THEN return Left<FailureResponse>
    ''', () async {
      when(() => _mockProductRemoteSource.getProductCategories())
          .thenThrow(DioError(requestOptions: RequestOptions(path: "")));

      final result = await _productRepository.getProductCategories();

      expect(result, isA<Left>());
    });

    test('''Success \t
      GIVEN Right<ProductResponseDTO> from RemoteDataSource
      WHEN getProducts method execute
      THEN return Right<ProductDataEntity>
    ''', () async {
      when(() => _mockProductRemoteSource.getProducts()).thenAnswer(
          (invocation) async => Future.value(productResponseDTODummy));

      final result = await _productRepository.getProducts();

      verify(() => _mockProductRemoteSource.getProducts());

      expect(result, isA<Right>());
      expect(
        result.getOrElse(() => ProductDataEntity(
              count: 1,
              countPerPage: 1,
              currentPage: 1,
              data: [],
            )),
        isA<ProductDataEntity>(),
      );
      expect(
        result
            .getOrElse(() => ProductDataEntity(
                  count: 0,
                  countPerPage: 0,
                  currentPage: 0,
                  data: [],
                ))
            .countPerPage,
        productResponseDTODummy?.data?.countPerPage,
      );
      expect(
        result
            .getOrElse(() => ProductDataEntity(
                count: 0, countPerPage: 0, currentPage: 0, data: []))
            .data
            .first
            .name,
        productResponseDTODummy?.data?.data?.first.name,
      );
    });

    test('''Fail \t
      GIVEN Right<ProductCategoryResponseDTO> from RemoteDataSource
      WHEN getProductCategories method execute
      THEN return Left<FailureResponse>
    ''', () async {
      when(() => _mockProductRemoteSource.getProducts())
          .thenThrow(DioError(requestOptions: RequestOptions(path: "")));

      final result = await _productRepository.getProducts();

      expect(result, isA<Left>());
    });

    test('''Success \t
      GIVEN Right<ProductDetailDataEntity> from RemoteDataSource
      WHEN getProductDetail method execute
      THEN return Right<ProductDetailDataEntity>
    ''', () async {
      when(() => _mockProductRemoteSource.getProductDetail(any()))
          .thenAnswer((_) async => Future.value(productDetailResponseDtoDummy));

      final result = await _productRepository.getProductDetail("1");

      verify(() => _mockProductRemoteSource.getProductDetail("1"));

      expect(result, isA<Right>());
      expect(result.getOrElse(() => const ProductDetailDataEntity()),
          isA<ProductDetailDataEntity>());
      expect(
        result.getOrElse(() => const ProductDetailDataEntity()).name,
        productDetailResponseDtoDummy?.data?.name,
      );
    });

    test('''Fail \t
      GIVEN Right<ProductDetailDataEntity> from RemoteDataSource
      WHEN getProductDetail method execute
      THEN return Left<FailureResponse>
    ''', () async {
      when(() => _mockProductRemoteSource.getProductDetail(any()))
          .thenThrow(DioError(requestOptions: RequestOptions(path: "")));

      final result = await _productRepository.getProductDetail('1');

      expect(result, isA<Left>());
    });

    test('''Success \t
      GIVEN Right<ProductDetailDataEntity> from RemoteDataSource
      WHEN getSeller method execute
      THEN return Right<ProductDetailDataEntity>
    ''', () async {
      when(() => _mockProductRemoteSource.getSeller(any()))
          .thenAnswer((_) async => Future.value(sellerResponseDtoDummy));

      final result = await _productRepository.getSeller("1");

      verify(() => _mockProductRemoteSource.getSeller("1"));

      expect(result, isA<Right>());
      expect(result.getOrElse(() => const SellerDataEntity()),
          isA<SellerDataEntity>());
      expect(
        result.getOrElse(() => const SellerDataEntity()).username,
        sellerResponseDtoDummy?.data?.username,
      );
    });

    test('''Fail \t
      GIVEN Right<ProductDetailDataEntity> from RemoteDataSource
      WHEN getSeller method execute
      THEN return Left<FailureResponse>
    ''', () async {
      when(() => _mockProductRemoteSource.getSeller(any()))
          .thenThrow(DioError(requestOptions: RequestOptions(path: "")));

      final result = await _productRepository.getSeller('1');

      verify(() => _mockProductRemoteSource.getSeller("1"));

      expect(result, isA<Left>());
    });
  });
}
