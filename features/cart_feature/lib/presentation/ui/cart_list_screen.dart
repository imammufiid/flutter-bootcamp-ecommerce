import 'package:cart_feature/presentation/bloc/bloc.dart';
import 'package:common/utils/extensions/money_extension.dart';
import 'package:common/utils/navigation/router/cart_router.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/button/custom_button.dart';
import 'package:component/widget/card/cart_card.dart';
import 'package:component/widget/divider/custom_divider.dart';
import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:component/widget/stack/loading_stack.dart';
import 'package:component/widget/toast/custom_toast.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:resources/colors.gen.dart';
import 'package:component/widget/checkbox/custom_check_box.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({Key? key}) : super(key: key);

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  final _cartRouter = sl<CartRouter>();

  @override
  void initState() {
    super.initState();
    _loadGetCarts();
  }

  void _loadGetCarts() {
    context.read<CartCubit>().getCarts();
  }

  void _addProduct({required String productId, required int index}) {
    context
        .read<CartCubit>()
        .addProduct(productId: productId, amount: 1, index: index);
  }

  void _deleteProduct({required String productId, required int index}) {
    context
        .read<CartCubit>()
        .deleteProduct(productId: productId, amount: 1, index: index);
  }

  void _selectAllProduct({required bool value}) {
    context.read<CartCubit>().selectAll(value);
  }

  void _selectProduct({
    required bool selected,
    required int index,
  }) {
    context.read<CartCubit>().selectProduct(selected, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.white,
      appBar: AppBar(
        backgroundColor: ColorName.white,
        centerTitle: false,
        title: const Text(
          "Keranjang",
          style:
              TextStyle(color: ColorName.orange, fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(color: ColorName.orange),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.star_border_outlined,
              color: ColorName.orange,
            ),
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            final addCartStatus = state.addCartState.status;
            final deleteCartStatus = state.deleteCartState.status;

            if (addCartStatus.isError) {
              CustomToast.showErrorToast(
                  errorMessage: state.addCartState.message);
            }

            if (deleteCartStatus.isError) {
              CustomToast.showErrorToast(
                  errorMessage: state.deleteCartState.message);
            }
          },
          builder: (context, state) {
            final cartListStatus = state.cartListState.status;
            if (cartListStatus.isLoading) {
              return const Center(child: CustomCircularProgressIndicator());
            } else if (cartListStatus.isHasData) {
              final carts = state.cartListState.data?.product ?? [];
              final loadingAddProduct = state.addCartState.status.isLoading;
              final loadingDeleteProduct =
                  state.deleteCartState.status.isLoading;
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _CustomDivider(),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          children: [
                            CustomCheckBox(
                              value: state.selectAll,
                              onChanged: (bool? value) =>
                                  _selectAllProduct(value: value ?? false),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "Pilih Semua",
                              style: TextStyle(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      const _CustomDivider(),
                      Expanded(
                        child: LoadingStack(
                          isLoading: loadingAddProduct || loadingDeleteProduct,
                          widget: ListView.builder(
                            shrinkWrap: true,
                            itemCount: carts.length,
                            itemBuilder: (context, index) {
                              final cart = carts[index];
                              final productId = cart.product.id;
                              final selectProduct = state.selectProducts[index];
                              return CartCard(
                                cart: cart,
                                value: selectProduct,
                                selectProductChanged: (bool? value) {
                                  final selected = value ?? false;
                                  _selectProduct(
                                      selected: selected, index: index);
                                },
                                addProductChanged: () => _addProduct(
                                    productId: productId, index: index),
                                deleteProductChanged: () => _deleteProduct(
                                    productId: productId, index: index),
                                loadingAddProduct: loadingAddProduct,
                                loadingDeleteProduct: loadingDeleteProduct,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h)
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: ColorName.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomDivider(),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Harga",
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        state.totalAmount.toIDR(),
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: ColorName.orange),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                Expanded(
                                  child: CustomButton(
                                    buttonText: "Beli",
                                    buttonColor: state.totalAmount == 0
                                        ? ColorName.textFieldHintGrey
                                        : ColorName.orange,
                                    onTap: state.totalAmount == 0
                                        ? null
                                        : () => _cartRouter.navigateToPayment(
                                            state.totalAmount, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else if (cartListStatus.isError) {
              return Text(state.cartListState.failure?.errorMessage ?? "");
            } else if (cartListStatus.isNoData) {
              return const Text("No Data");
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class _CustomDivider extends StatelessWidget {
  final double height;

  const _CustomDivider({Key? key, this.height = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: double.infinity,
      color: ColorName.textFieldBackgroundGrey,
    );
  }
}
