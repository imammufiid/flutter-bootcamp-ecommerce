import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:home_page/presentation/bloc/product_category_bloc/product_category_state.dart';
import 'package:product/domain/usecase/get_product_category_usecase.dart';

class ProductCategoryCubit extends Cubit<ProductCategoryState> {
  final GetProductCategoryUseCase productCategoryUseCase;

  ProductCategoryCubit({required this.productCategoryUseCase})
      : super(ProductCategoryState(productCategoryState: ViewData.initial()));

  void getProductCategories() async {
    emit(ProductCategoryState(productCategoryState: ViewData.loading()));
    final result = await productCategoryUseCase(const NoParams());
    result.fold(
      (failure) => emit(
        ProductCategoryState(
          productCategoryState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        ProductCategoryState(
          productCategoryState: ViewData.loaded(data: result),
        ),
      ),
    );
  }
}
