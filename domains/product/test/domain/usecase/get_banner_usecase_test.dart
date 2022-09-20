import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product/domain/entity/response/banner_data_entity.dart';
import 'package:product/domain/repository/product_repository.dart';
import 'package:product/domain/usecase/get_banner_usecase.dart';

import '../../helper/entity/banner_entity_dummy.dart';

void main() => testGetBannerUseCaseTest();

class MockProductRepository extends Mock implements ProductRepository {}

void testGetBannerUseCaseTest() {
  late final ProductRepository _mockProductRepository;
  late final GetBannerUseCase _getBannerUseCase;

  setUpAll(() {
    _mockProductRepository = MockProductRepository();
    _getBannerUseCase = GetBannerUseCase(repository: _mockProductRepository);
  });

  group('Get Banner UseCase', () {
    test('''Success \t
      GIVEN Right<List<BannerDataEntity>> from ProductRepository
      WHEN call method executed
      THEN return Right<List<BannerDataEntity>>
    ''', () async {
      // GIVEN
      when(() => _mockProductRepository.getBanners())
          .thenAnswer((_) async => Right(bannerEntityDummy));

      // WHEN
      final result = await _getBannerUseCase.call(const NoParams());

      // THEN
      expect(result, isA<Right>());
      expect(result.getOrElse(() => []).first, isA<BannerDataEntity>());
      expect(
        result.getOrElse(() => []).first.name,
        bannerEntityDummy.first.name,
      );
    });

    test('''Fail \t
      GIVEN Left<Failure> from ProductRepository
      WHEN call method executed
      THEN return Left<Failure>
    ''', () async {
      // GIVEN
      when(() => _mockProductRepository.getBanners()).thenAnswer(
          (_) async => const Left(FailureResponse(errorMessage: '')));

      // WHEN
      final result = await _getBannerUseCase.call(const NoParams());

      // THEN
      expect(result, isA<Left>());
    });
  });
}
