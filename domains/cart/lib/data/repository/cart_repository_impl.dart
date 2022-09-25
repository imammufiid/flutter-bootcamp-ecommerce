import 'package:cart/data/source/cart_remote_source.dart';
import 'package:cart/domain/entity/request/add_to_cart_entity.dart';
import 'package:cart/domain/entity/response/cart_entity.dart';
import 'package:cart/domain/repository/cart_repository.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteSource remoteSource;

  CartRepositoryImpl({required this.remoteSource});

  @override
  Future<Either<FailureResponse, CartDataEntity>> addToCart(
      AddToCartEntity body) {
    // TODO: implement addToCart
    throw UnimplementedError();
  }

  @override
  Future<Either<FailureResponse, CartDataEntity>> deleteCart(
      AddToCartEntity body) {
    // TODO: implement deleteCart
    throw UnimplementedError();
  }

  @override
  Future<Either<FailureResponse, CartDataEntity>> getCarts() {
    // TODO: implement getCarts
    throw UnimplementedError();
  }
}
