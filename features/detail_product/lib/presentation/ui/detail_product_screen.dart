import 'package:common/utils/extensions/money_extension.dart';
import 'package:common/utils/navigation/argument/arguments.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/appbar/custom_appbar.dart';
import 'package:component/widget/button/payment_button.dart';
import 'package:component/widget/divider/divider.dart';
import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/cached_network_image/cached_network_image.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:detail_product/presentation/bloc/product_detail_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:product/domain/entity/response/product_detail_entity.dart';
import 'package:product/domain/entity/response/seller_data_entity.dart';
import 'package:resources/colors.gen.dart';
import 'package:dependencies/flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class DetailProductScreen extends StatefulWidget {
  final DetailProductArgument argument;

  const DetailProductScreen({Key? key, required this.argument})
      : super(key: key);

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  @override
  void initState() {
    super.initState();
    _loadProductDetail(context);
  }

  void _loadProductDetail(BuildContext context) {
    context.read<ProductDetailCubit>().getProduct(widget.argument.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.white,
      appBar: CustomAppBar(
        onPressed: () {},
      ),
      body: Center(
        child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
            final status = state.productState.status;
            if (status.isLoading) {
              return const CustomCircularProgressIndicator();
            } else if (status.isHasData) {
              final product =
                  state.productState.data ?? const ProductDetailDataEntity();
              return Stack(
                children: [
                  ListView(
                    children: [
                      CachedNetworkImage(imageUrl: product.imageUrl),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    product.price.toIDR(),
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.star_border_outlined,
                                  color: ColorName.orange,
                                )
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Terjual ${product.soldCount}",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 19.h),
                      const _Seller(),
                      SizedBox(height: 19.h),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Informasi Produk",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kategori",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  product.category.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: ColorName.orange,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 19.h),
                      const CustomDivider(),
                      SizedBox(height: 19.h),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Deskripsi Produk",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            HtmlWidget(
                              product.description,
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(height: 60.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                  PaymentButton(
                    onPressedBuy: () {},
                    onPressedCart: () {},
                  )
                ],
              );
            } else if (status.isError) {
              final failureMessage = state.productState.failure?.errorMessage;
              return Text(failureMessage ?? state.productState.message);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class _Seller extends StatelessWidget {
  const _Seller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomDivider(),
        BlocBuilder<ProductDetailCubit, ProductDetailState>(
            builder: (context, state) {
          final status = state.sellerState.status;
          if (status.isLoading) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: const CustomCircularProgressIndicator(),
            );
          } else if (status.isHasData) {
            final seller = state.sellerState.data ?? const SellerDataEntity();
            return Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 13.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    child: CachedNetworkImage(
                      width: 40.w,
                      height: 40.w,
                      imageUrl: seller.imageUrl,
                      placeholder: (context, url) => const Center(
                        child: CustomCircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        seller.fullName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Text(
                        seller.city,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else if (status.isError) {
            final failureMessage = state.sellerState.failure?.errorMessage;
            return Text(failureMessage ?? state.sellerState.message);
          } else {
            return const SizedBox();
          }
        }),
        const CustomDivider(),
      ],
    );
  }
}
