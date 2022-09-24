import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product/domain/entity/response/product_entity.dart';
import 'package:product/domain/repository/product_repository.dart';
import 'package:product/domain/usecase/get_product_usecase.dart';

import '../../helper/entity/banner_entity_dummy.dart';

void main() => testGetProductsUseCase();

class MockProductRepository extends Mock implements ProductRepository {}

void testGetProductsUseCase() {
  late final ProductRepository _mockProductRepository;
  late final GetProductUseCase _getProductUseCase;

  setUpAll(() {
    _mockProductRepository = MockProductRepository();
    _getProductUseCase = GetProductUseCase(repository: _mockProductRepository);
  });

  group('''Get Products UseCase''', () {
    test('''Success \t
      GIVEN Right<ProductDataEntity> from ProductRepository
      WHEN call method executed
      THEN return Right<ProductDataEntity>
    ''', () async {
      // GIVEN
      when(() => _mockProductRepository.getProducts())
          .thenAnswer((_) async => Right(productsDataDummy));
      // WHEN
      final result = await _getProductUseCase.call(const NoParams());
      // THEN
      expect(result, isA<Right>());
      expect(
          result.getOrElse(
            () => ProductDataEntity(
              count: 0,
              countPerPage: 0,
              currentPage: 0,
              data: [],
            ),
          ),
          isA<ProductDataEntity>());
    });

    test('''Fail \t
      GIVEN Left<Failure> from ProductRepository
      WHEN call method executed
      THEN return Left<Failure>
    ''', () async {
      // GIVEN
      when(() => _mockProductRepository.getProducts()).thenAnswer(
              (_) async => const Left(FailureResponse(errorMessage: '')));

      // WHEN
      final result = await _getProductUseCase.call(const NoParams());

      // THEN
      expect(result, isA<Left>());
    });
  });
}
