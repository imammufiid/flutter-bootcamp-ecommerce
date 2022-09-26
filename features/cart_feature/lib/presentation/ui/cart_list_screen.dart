import 'package:cart_feature/presentation/bloc/bloc.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/card/cart_card.dart';
import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:resources/colors.gen.dart';
import 'package:component/widget/checkbox/custom_check_box.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({Key? key}) : super(key: key);

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  void initState() {
    super.initState();
    _loadGetCarts();
  }

  void _loadGetCarts() {
    context.read<CartCubit>().getCarts();
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
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final cartListStatus = state.cartListState.status;
            if (cartListStatus.isLoading) {
              return const Center(child: CustomCircularProgressIndicator());
            } else if (cartListStatus.isHasData) {
              final carts = state.cartListState.data?.product ?? [];
              return Column(
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
                          value: false,
                          onChanged: (bool? value) {},
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: carts.length,
                      itemBuilder: (context, index) {
                        final cart = carts[index];
                        return CartCard(
                          cart: cart,
                          value: false,
                          selectProductChanged: (bool? value) {},
                          addProductChanged: () {},
                          deleteProductChanged: () {},
                          loadingAddProduct: false,
                          loadingDeleteProduct: false,
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (cartListStatus.isError) {
              return Text(state.cartListState.failure?.errorMessage ?? "");
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
