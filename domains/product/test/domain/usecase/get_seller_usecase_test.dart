import 'package:common/utils/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product/domain/entity/response/seller_data_entity.dart';
import 'package:product/domain/repository/product_repository.dart';
import 'package:product/domain/usecase/get_seller_usecase.dart';

import '../../helper/entity/banner_entity_dummy.dart';

void main() => testGetSellerUseCase();

class MockProductRepository extends Mock implements ProductRepository {}

void testGetSellerUseCase() {
  late final ProductRepository _mockProductRepository;
  late final GetSellerUseCase _getSellerUseCase;

  setUpAll(() {
    _mockProductRepository = MockProductRepository();
    _getSellerUseCase = GetSellerUseCase(repository: _mockProductRepository);
  });

  group('Get Seller UseCase', () {
    test('''Success \t
        GIVEN Right<SellerDataEntity> from ProductRepository
        WHEN call method executed
        THEN return Right<SellerDataEntity>
    ''', () async {
      // GIVEN
      when(() => _mockProductRepository.getSeller(any()))
          .thenAnswer((_) async => Right(sellerDataDummy));

      // WHEN
      final result = await _getSellerUseCase.call("1");

      // THEN
      verify(() => _mockProductRepository.getSeller("1"));
      expect(result, isA<Right>());
      expect(result.getOrElse(() => const SellerDataEntity()),
          isA<SellerDataEntity>());
      expect(
        result.getOrElse(() => const SellerDataEntity()).username,
        sellerDataDummy.username,
      );
    });

    test('''Fail \t
      GIVEN Left<Failure> from ProductRepository
      WHEN call method executed
      THEN return Left<Failure>
    ''', () async {
      // GIVEN
      when(() => _mockProductRepository.getSeller(any())).thenAnswer(
          (_) async => const Left(FailureResponse(errorMessage: '')));

      // WHEN
      final result = await _getSellerUseCase.call("1");

      // THEN
      expect(result, isA<Left>());
    });
  });
}
