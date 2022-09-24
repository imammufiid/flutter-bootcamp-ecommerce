import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product/domain/entity/response/product_category_entity.dart';
import 'package:product/domain/repository/product_repository.dart';
import 'package:product/domain/usecase/get_product_category_usecase.dart';

import '../../helper/entity/banner_entity_dummy.dart';

void main() => testGetProductCategoryUseCase();

class MockProductRepository extends Mock implements ProductRepository {}

void testGetProductCategoryUseCase() {
  late final ProductRepository _mockProductRepository;
  late final GetProductCategoryUseCase _getProductCategoryUseCase;

  setUpAll(() {
    _mockProductRepository = MockProductRepository();
    _getProductCategoryUseCase =
        GetProductCategoryUseCase(repository: _mockProductRepository);
  });

  group('''Get Product UseCase''', () {
    test('''Success \t
      GIVEN Right<List<ProductCategoryEntity>> from ProductRepository
      WHEN call method executed
      THEN return Right<List<ProductCategoryEntity>>
    ''', () async {
      // GIVEN
      when(() => _mockProductRepository.getProductCategories())
          .thenAnswer((_) async => Right(productCategoryDummy));

      // WHEN
      final result = await _getProductCategoryUseCase.call(const NoParams());

      // THEN
      expect(result, isA<Right>());
      expect(result.getOrElse(() => []).first, isA<ProductCategoryEntity>());
      expect(
        result.getOrElse(() => []).first.name,
        productCategoryDummy.first.name,
      );
    });

    test('''Fail \t
      GIVEN Left<Failure> from ProductRepository
      WHEN call method executed
      THEN return Left<Failure>
    ''', () async {
      // GIVEN
      when(() => _mockProductRepository.getProductCategories()).thenAnswer(
          (_) async => const Left(FailureResponse(errorMessage: '')));

      // WHEN
      final result = await _getProductCategoryUseCase.call(const NoParams());

      // THEN
      expect(result, isA<Left>());
    });
  });
}
