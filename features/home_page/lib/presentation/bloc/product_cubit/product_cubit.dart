import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:home_page/presentation/bloc/product_cubit/product_state.dart';
import 'package:product/domain/entity/response/product_entity.dart';
import 'package:product/domain/usecase/get_product_usecase.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductUseCase productUseCase;

  ProductCubit({required this.productUseCase})
      : super(ProductState(productState: ViewData.initial()));

  void getProducts() async {
    emit(ProductState(productState: ViewData.loading()));
    final result = await productUseCase(const NoParams());
    result.fold(
      (failure) => _onFailureGetProducts(failure),
      (result) => _onSuccessGetProducts(result),
    );
  }

  void _onFailureGetProducts(FailureResponse failure) {
    emit(
      ProductState(
        productState: ViewData.error(
          message: failure.errorMessage,
          failure: failure,
        ),
      ),
    );
  }

  void _onSuccessGetProducts(ProductDataEntity data) {
    emit(ProductState(productState: ViewData.loaded(data: data)));
  }
}
