import 'package:cart/domain/entity/request/add_to_cart_entity.dart';
import 'package:cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:detail_product/presentation/bloc/product_detail_bloc/product_detail_state.dart';
import 'package:product/domain/entity/response/product_detail_entity.dart';
import 'package:product/domain/entity/response/seller_data_entity.dart';
import 'package:product/domain/usecase/delete_product_usecase.dart';
import 'package:product/domain/usecase/get_favorite_product_by_url_usecase.dart';
import 'package:product/domain/usecase/get_product_detail_usecase.dart';
import 'package:product/domain/usecase/get_seller_usecase.dart';
import 'package:product/domain/usecase/save_product_usecase.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProductDetailUseCase getProductDetailUseCase;
  final GetSellerUseCase getSellerUseCase;
  final AddToCartUseCase addToCartUseCase;
  final SaveProductUseCase saveProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final GetFavoriteProductByUrlUseCase getFavoriteProductByUrlUseCase;

  ProductDetailCubit({
    required this.getProductDetailUseCase,
    required this.getSellerUseCase,
    required this.addToCartUseCase,
    required this.saveProductUseCase,
    required this.deleteProductUseCase,
    required this.getFavoriteProductByUrlUseCase,
  }) : super(ProductDetailState(
          productState: ViewData.initial(),
          sellerState: ViewData.initial(),
          addToCartState: ViewData.initial(),
          saveProductState: ViewData.initial(),
          deleteProductState: ViewData.initial(),
          isFavorite: false,
        ));

  void getProduct(String productId) async {
    emit(state.copyWith(productState: ViewData.loading()));
    final result = await getProductDetailUseCase.call(productId);
    result.fold(
      (failure) => _onFailureProduct(failure),
      (data) => _onSuccessProduct(data),
    );
  }

  Future<void> _onFailureProduct(FailureResponse failure) async {
    emit(state.copyWith(
      productState:
          ViewData.error(message: failure.errorMessage, failure: failure),
    ));
  }

  Future<void> _onSuccessProduct(ProductDetailDataEntity data) async {
    emit(state.copyWith(
      productState: ViewData.loaded(data: data),
    ));
    await _getSeller.call(data.seller.id);
  }

  Future<void> _getSeller(String sellerId) async {
    emit(state.copyWith(sellerState: ViewData.loading()));
    final result = await getSellerUseCase.call(sellerId);
    return result.fold(
      (failure) => _onFailureSeller(failure),
      (data) => _onSuccessSeller(data),
    );
  }

  Future<void> _onFailureSeller(FailureResponse failure) async {
    emit(state.copyWith(
      sellerState:
          ViewData.error(message: failure.errorMessage, failure: failure),
    ));
  }

  Future<void> _onSuccessSeller(SellerDataEntity data) async {
    emit(state.copyWith(
      sellerState: ViewData.loaded(data: data),
    ));
  }

  addToChart(AddToCartEntity body) async {
    emit(state.copyWith(addToCartState: ViewData.loading()));
    final result = await addToCartUseCase.call(body);
    result.fold(
      (failure) => _onFailureAddToChart(failure),
      (_) => _onSuccessAddToChart(body),
    );
  }

  Future<void> _onFailureAddToChart(
    FailureResponse failure,
  ) async {
    emit(state.copyWith(
      addToCartState:
          ViewData.error(message: failure.errorMessage, failure: failure),
    ));
  }

  Future<void> _onSuccessAddToChart(
    AddToCartEntity data,
  ) async {
    emit(state.copyWith(addToCartState: ViewData.loaded(data: data)));
  }

  void saveProduct(ProductDetailDataEntity data) async {
    final result = await saveProductUseCase.call(data);
    result.fold(
      (failure) => _onFailureSaveProduct(failure),
      (data) => _onSuccessSaveProduct(data),
    );
  }

  void _onFailureSaveProduct(FailureResponse failure) {
    emit(state.copyWith(
      saveProductState:
          ViewData.error(message: failure.errorMessage, failure: failure),
    ));
  }

  void _onSuccessSaveProduct(bool data) {
    emit(state.copyWith(
        saveProductState: ViewData.loaded(data: data), isFavorite: true));
  }

  void deleteProduct(String productURL) async {
    final result = await deleteProductUseCase.call(productURL);
    result.fold(
      (failure) => _onFailureDeleteProduct(failure),
      (data) => _onSuccessDeleteProduct(data),
    );
  }

  void _onFailureDeleteProduct(FailureResponse failure) {
    emit(state.copyWith(
      deleteProductState:
          ViewData.error(message: failure.errorMessage, failure: failure),
    ));
  }

  void _onSuccessDeleteProduct(bool data) {
    emit(state.copyWith(
        deleteProductState: ViewData.loaded(data: data), isFavorite: false));
  }

  void getProductFavorite(String imageUrl) async {
    final result = await getFavoriteProductByUrlUseCase.call(imageUrl);
    return result.fold(
      (_) => _onFailureGetProduct(),
      (_) => _onSuccessGetProduct(),
    );
  }

  void _onFailureGetProduct() {
    emit(state.copyWith(isFavorite: false));
  }

  void _onSuccessGetProduct() {
    emit(state.copyWith(isFavorite: true));
  }
}
