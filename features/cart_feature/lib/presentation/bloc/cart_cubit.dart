import 'package:cart/domain/entity/request/add_to_cart_entity.dart';
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
    required int index,
  }) async {
    emit(state.copyWith(deleteCartState: ViewData.loading()));
    final result = await deleteCartUseCase
        .call(AddToCartEntity(productId: productId, amount: amount));
    return result.fold(
      (failure) => _onFailureDeleteCart(failure),
      (result) => _onSuccessDeleteCart(result, index),
    );
  }

  Future<void> _onFailureDeleteCart(FailureResponse failure) async {
    emit(state.copyWith(
      deleteCartState:
          ViewData.error(message: failure.errorMessage, failure: failure),
    ));
  }

  Future<void> _onSuccessDeleteCart(CartDataEntity data, int index) async {
    if (data.product.isEmpty) {
      emit(state.copyWith(
        deleteCartState: ViewData.noData(message: "No Data"),
        cartListState: ViewData.noData(message: "No Data"),
      ));
    } else {
      int amount = 0;
      if (state.selectAll || state.selectProducts[index]) {
        amount = state.totalAmount - data.product[index].product.price;
      } else {
        amount = state.totalAmount;
      }

      if (!state.selectProducts[index]) {
        amount = state.totalAmount;
      }

      emit(state.copyWith(
        totalAmount: amount,
        deleteCartState: ViewData.loaded(data: data),
        cartListState: ViewData.loaded(data: data),
      ));
    }
  }

  void addProduct({
    required String productId,
    required int amount,
    required int index,
  }) async {
    emit(state.copyWith(addCartState: ViewData.loading()));
    final product = AddToCartEntity(productId: productId, amount: amount);
    final result = await addToCartUseCase.call(product);
    return result.fold(
      (failure) => _onFailureAddCart(failure),
      (result) => _onSuccessAddCart(result, index),
    );
  }

  Future<void> _onFailureAddCart(FailureResponse failure) async {
    emit(state.copyWith(
      addCartState:
          ViewData.error(message: failure.errorMessage, failure: failure),
    ));
  }

  Future<void> _onSuccessAddCart(CartDataEntity data, int index) async {
    int amount = 0;
    if (state.selectAll || state.selectProducts[index]) {
      amount = state.totalAmount + data.product[index].product.price;
    } else {
      amount = state.totalAmount;
    }

    if (!state.selectProducts[index]) {
      amount = state.totalAmount;
    }
    emit(state.copyWith(
      totalAmount: amount,
      addCartState: ViewData.loaded(data: data),
      cartListState: ViewData.loaded(data: data),
    ));
  }

  void selectAll(bool selected) {
    if (selected) {
      var data = state.cartListState.data?.product
          .map((e) => (e.product.price * e.quantity))
          .reduce((value, element) => value + element);
      var selectProduct =
          state.cartListState.data?.product.map((_) => true).toList();

      emit(state.copyWith(
        totalAmount: data,
        selectAll: selected,
        selectProducts: selectProduct,
      ));
    } else {
      var selectProduct =
          state.cartListState.data?.product.map((_) => false).toList();
      emit(state.copyWith(
        totalAmount: 0,
        selectAll: false,
        selectProducts: selectProduct,
      ));
    }
  }

  void selectProduct(bool selected, int index) {
    /// tmp
    int amount = 0;
    final selectProduct = <bool>[];

    /// from state
    final productState = state.cartListState.data?.product ?? [];
    final selectProductState = state.selectProducts;
    final totalAmountState = state.totalAmount;

    /// set data
    selectProduct.addAll(selectProductState);
    selectProduct[index] = selected;
    final productAmount =
        productState[index].product.price * productState[index].quantity;
    amount = totalAmountState;

    if (selected) {
      var isNotSelectAll = !selectProduct.contains(false);
      amount += productAmount;
      emit(state.copyWith(
        totalAmount: amount,
        selectProducts: selectProduct,
        selectAll: isNotSelectAll,
      ));
    } else {
      var isNotSelectAll = !selectProduct.contains(false);
      amount -= productAmount;
      emit(state.copyWith(
        totalAmount: amount,
        selectAll: isNotSelectAll,
        selectProducts: selectProduct,
      ));
    }
  }

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
      final selectProduct = <bool>[];

      for (var _ in data.product) {
        selectProduct.add(false);
      }

      emit(state.copyWith(
        cartListState: ViewData.loaded(data: data),
        totalAmount: 0,
        selectAll: false,
        selectProducts: selectProduct,
      ));
    }
  }
}
