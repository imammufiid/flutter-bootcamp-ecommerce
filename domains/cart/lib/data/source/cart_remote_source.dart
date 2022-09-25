import 'package:cart/data/model/request/add_to_cart_dto.dart';
import 'package:cart/data/model/response/cart_response_dto.dart';
import 'package:dependencies/dio/dio.dart';

abstract class CartRemoteSource {
  const CartRemoteSource();

  Future<CartResponseDto> addToCart(AddToCartDTO body);

  Future<CartResponseDto> getCart();

  Future<CartResponseDto> deleteCart(AddToCartDTO body);
}

class CartRemoteSourceImpl implements CartRemoteSource {
  final Dio dio;

  CartRemoteSourceImpl({required this.dio});

  @override
  Future<CartResponseDto> addToCart(AddToCartDTO body) {
    // TODO: implement addToCart
    throw UnimplementedError();
  }

  @override
  Future<CartResponseDto> deleteCart(AddToCartDTO body) {
    // TODO: implement deleteCart
    throw UnimplementedError();
  }

  @override
  Future<CartResponseDto> getCart() {
    // TODO: implement getCart
    throw UnimplementedError();
  }
}
