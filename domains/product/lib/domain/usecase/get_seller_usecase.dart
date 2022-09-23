import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:product/domain/entity/response/seller_data_entity.dart';
import 'package:product/domain/repository/product_repository.dart';

class GetSellerUseCase extends UseCase<SellerDataEntity, String> {
  final ProductRepository repository;

  GetSellerUseCase({required this.repository});

  @override
  Future<Either<FailureResponse, SellerDataEntity>> call(String params) async =>
      await repository.getSeller(params);
}
