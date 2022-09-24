import 'package:common/utils/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product/domain/entity/response/product_detail_entity.dart';
import 'package:product/domain/repository/product_repository.dart';
import 'package:product/domain/usecase/get_product_detail_usecase.dart';

import '../../helper/entity/banner_entity_dummy.dart';

void main() => testGetProductDetailUseCase();

class MockProductRepository extends Mock implements ProductRepository {}

testGetProductDetailUseCase() {
  late final ProductRepository _mockProductRepository;
  late final GetProductDetailUseCase _getProductDetailUseCase;

  setUpAll(() {
    _mockProductRepository = MockProductRepository();
    _getProductDetailUseCase =
        GetProductDetailUseCase(repository: _mockProductRepository);
  });

  group('''Get Product Detail UseCase''', () {
    test('''Success \t
      GIVEN Right<ProductDetailDataEntity> from ProductRepository
      WHEN call method executed
      THEN return Right<ProductDetailDataEntity>
    ''', () async {
      // GIVEN
      when(() => _mockProductRepository.getProductDetail(any()))
          .thenAnswer((_) async => Right(productDetailDummy));

      // WHEN
      final result = await _getProductDetailUseCase.call("1");

      // THEN
      verify(() => _mockProductRepository.getProductDetail("1"));
      expect(result, isA<Right>());
      expect(result.getOrElse(() => const ProductDetailDataEntity()),
          isA<ProductDetailDataEntity>());
      expect(result.getOrElse(() => const ProductDetailDataEntity()).name,
          productDetailDummy.name);
    });

    test('''Fail \t
      GIVEN Left<Failure> from ProductRepository
      WHEN call method executed
      THEN return Left<Failure> 
    ''', () async {
      // GIVEN
      when(() => _mockProductRepository.getProductDetail(any())).thenAnswer(
          (_) async => const Left(FailureResponse(errorMessage: '')));

      // WHEN
      final result = await _getProductDetailUseCase.call("1");

      // THEN
      verify(() => _mockProductRepository.getProductDetail("1"));
      expect(result, isA<Left>());
    });
  });
}
