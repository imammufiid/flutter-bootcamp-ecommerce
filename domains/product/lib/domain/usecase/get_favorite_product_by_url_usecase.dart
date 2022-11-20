import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:product/domain/entity/response/product_detail_entity.dart';
import 'package:product/domain/repository/product_repository.dart';

class GetFavoriteProductByUrlUseCase
    extends UseCase<ProductDetailDataEntity, String> {
  final ProductRepository repository;

  GetFavoriteProductByUrlUseCase({
    required this.repository,
  });

  @override
  Future<Either<FailureResponse, ProductDetailDataEntity>> call(
          String params) async =>
      await repository.getFavoriteProductByUrl(params);
}
