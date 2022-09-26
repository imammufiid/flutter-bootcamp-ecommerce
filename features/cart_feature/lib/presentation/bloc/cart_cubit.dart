import 'package:cart/domain/entity/response/cart_entity.dart';
import 'package:cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:cart/domain/usecase/delete_cart_usecase.dart';
import 'package:cart/domain/usecase/get_carts_usecase.dart';
import 'package:cart_feature/presentation/bloc/bloc.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartsUseCase getCartsUseCase;
  final AddToCartUseCase addToCartUseCase;
  final DeleteCartUseCase deleteCartUseCase;

  CartCubit({
    required this.getCartsUseCase,
    required this.addToCartUseCase,
    required this.deleteCartUseCase,
  }) : super(CartState(
          cartListState: ViewData.initial(),
          addCartState: ViewData.initial(),
          deleteCartState: ViewData.initial(),
        ));

  void deleteProduct({
    required String productId,
    required int amount,
  }) {}

  Future<void> _onFailureDeleteCart(FailureResponse failure) async {}

  Future<void> _onSuccessDeleteCart(CartDataEntity data) async {}

  void addProduct({
    required String productId,
    required int amount,
  }) {}

  Future<void> _onFailureAddCart(FailureResponse failure) async {}

  Future<void> _onSuccessAddCart(CartDataEntity data) async {}

  void selectAll(bool selected) {}

  void selectProduct(bool selected, int index) {}

  void getCarts() async {
    emit(state.copyWith(cartListState: ViewData.loading()));
    final result = await getCartsUseCase.call(const NoParams());
    result.fold(
      (failure) => _onFailureGetCart(failure),
      (result) => _onSuccessGetCart(result),
    );
  }

  Future<void> _onFailureGetCart(FailureResponse failure) async {
    emit(state.copyWith(
      cartListState:
          ViewData.error(message: failure.errorMessage, failure: failure),
    ));
  }

  Future<void> _onSuccessGetCart(CartDataEntity data) async {
    if (data.product.isEmpty) {
      emit(state.copyWith(cartListState: ViewData.noData(message: "No Data")));
    } else {
      emit(state.copyWith(cartListState: ViewData.loaded(data: data)));
    }
  }
}
