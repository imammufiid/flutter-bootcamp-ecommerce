import 'package:dependencies/dartz/dartz.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:dependencies/mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product/data/mapper/product_mapper.dart';
import 'package:product/data/repository/product_repository_impl.dart';
import 'package:product/data/source/remote/product_remote_source.dart';
import 'package:product/domain/entity/response/banner_data_entity.dart';
import 'package:product/domain/repository/product_repository.dart';

import '../../helper/model/banner_response_dto_dummy.dart';

void main() => testProductRepositoryTest();

class MockProductRemoteSource extends Mock implements ProductRemoteSource {}

void testProductRepositoryTest() {
  late final ProductRemoteSource _mockProductRemoteSource;
  late final ProductMapper _mockProductMapper;
  late final ProductRepository _productRepository;

  setUpAll(() {
    _mockProductRemoteSource = MockProductRemoteSource();
    _mockProductMapper = ProductMapper();
    _productRepository = ProductRepositoryImpl(
      remoteSource: _mockProductRemoteSource,
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
      THEN return Right<List<BannerDataEntity>>
    ''', () async {
      when(() => _mockProductRemoteSource.getBanners())
          .thenThrow(DioError(requestOptions: RequestOptions(path: "")));

      final result = await _productRepository.getBanners();

      expect(result, isA<Left>());
    });
  });
}
