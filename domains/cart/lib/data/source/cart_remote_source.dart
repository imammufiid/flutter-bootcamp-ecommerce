import 'package:cart/data/model/request/add_to_cart_dto.dart';
import 'package:cart/data/model/response/cart_response_dto.dart';
import 'package:common/utils/constants/app_constants.dart';
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
  Future<CartResponseDto> addToCart(AddToCartDTO body) async {
    try {
      final formData = FormData.fromMap({body.productId: body.amount});

      final response = await dio.post(AppConstants.appApi.cart, data: formData);

      return CartResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CartResponseDto> deleteCart(AddToCartDTO body) async {
    try {
      final formData = FormData.fromMap({body.productId: body.amount});

      final response =
          await dio.delete(AppConstants.appApi.cart, data: formData);

      return CartResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CartResponseDto> getCart() async {
    try {
      final response = await dio.get(AppConstants.appApi.cart);

      return CartResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
