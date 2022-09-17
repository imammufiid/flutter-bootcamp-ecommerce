import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:product/domain/entity/response/product_entity.dart';
import 'package:product/domain/repository/product_repository.dart';

class GetProductUseCase extends UseCase<ProductDataEntity, NoParams> {
  final ProductRepository repository;

  GetProductUseCase({required this.repository});

  @override
  Future<Either<FailureResponse, ProductDataEntity>> call(
          NoParams params) async =>
      await repository.getProducts();
}
