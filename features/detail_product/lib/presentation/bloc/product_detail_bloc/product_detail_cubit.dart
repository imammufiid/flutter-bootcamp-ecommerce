import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:detail_product/presentation/bloc/product_detail_bloc/product_detail_state.dart';
import 'package:product/domain/entity/response/product_detail_entity.dart';
import 'package:product/domain/entity/response/seller_data_entity.dart';
import 'package:product/domain/usecase/get_product_detail_usecase.dart';
import 'package:product/domain/usecase/get_seller_usecase.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProductDetailUseCase getProductDetailUseCase;
  final GetSellerUseCase getSellerUseCase;

  ProductDetailCubit({
    required this.getProductDetailUseCase,
    required this.getSellerUseCase,
  }) : super(ProductDetailState(
          productState: ViewData.initial(),
          sellerState: ViewData.initial(),
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
}
