import 'package:cart/domain/entity/request/add_to_cart_entity.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/equatable/equatable.dart';
import 'package:product/domain/entity/response/product_detail_entity.dart';
import 'package:product/domain/entity/response/seller_data_entity.dart';

class ProductDetailState extends Equatable {
  final ViewData<ProductDetailDataEntity> productState;
  final ViewData<SellerDataEntity> sellerState;
  final ViewData<AddToCartEntity> addToCartState;

  const ProductDetailState({
    required this.productState,
    required this.sellerState,
    required this.addToCartState,
  });

  ProductDetailState copyWith({
    ViewData<ProductDetailDataEntity>? productState,
    ViewData<SellerDataEntity>? sellerState,
    ViewData<AddToCartEntity>? addToCartState,
  }) {
    return ProductDetailState(
      productState: productState ?? this.productState,
      sellerState: sellerState ?? this.sellerState,
      addToCartState: addToCartState ?? this.addToCartState,
    );
  }

  @override
  List<Object?> get props => [productState, sellerState, addToCartState];
}
