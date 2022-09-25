import 'package:cart/domain/entity/response/cart_entity.dart';
import 'package:cart/domain/repository/cart_repository.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/dartz/dartz.dart';

class GetCartsUseCase extends UseCase<CartDataEntity, NoParams> {
  final CartRepository repository;

  GetCartsUseCase({required this.repository});

  @override
  Future<Either<FailureResponse, CartDataEntity>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
