import 'package:cart/domain/entity/request/add_to_cart_entity.dart';
import 'package:common/utils/extensions/money_extension.dart';
import 'package:common/utils/navigation/argument/arguments.dart';
import 'package:common/utils/navigation/router/product_routes.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/appbar/custom_appbar.dart';
import 'package:component/widget/button/custom_button.dart';
import 'package:component/widget/divider/custom_divider.dart';
import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:component/widget/stack/loading_stack.dart';
import 'package:component/widget/toast/custom_toast.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/cached_network_image/cached_network_image.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:dependencies/get_it/get_it.dart';
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
  final _productRouter = sl<ProductRoutes>();

  @override
  void initState() {
    super.initState();
    _loadProductDetail();
    _getProductFavorite(widget.argument.imageUrl);
  }

  void _closeBottomSheet(BuildContext context) => Navigator.pop(context);

  void _loadProductDetail() {
    context.read<ProductDetailCubit>().getProduct(widget.argument.productId);
  }

  void _saveProductToFavorite(ProductDetailDataEntity data) {
    context.read<ProductDetailCubit>().saveProduct(data);
  }

  void _deleteProductToFavorite(String productURL) {
    context.read<ProductDetailCubit>().deleteProduct(productURL);
  }

  void _getProductFavorite(String imageUrl) {
    context.read<ProductDetailCubit>().getProductFavorite(imageUrl);
  }

  void _addProductToCart(AddToCartEntity body) {
    context.read<ProductDetailCubit>().addToChart(body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.white,
      appBar: CustomAppBar(
        onPressed: () => _productRouter.navigateToCartList(),
      ),
      body: Center(
        child: BlocConsumer<ProductDetailCubit, ProductDetailState>(
          listener: (context, state) {
            final cartState = state.addToCartState.status;
            if (cartState.isError) {
              CustomToast.showErrorToast(
                errorMessage: state.addToCartState.failure!.errorMessage,
              );
            } else if (cartState.isHasData) {
              _showSuccessAddToChart(state.addToCartState.data!);
            }
          },
          builder: (context, state) {
            final status = state.productState.status;
            final cartStatus = state.addToCartState.status;
            if (status.isLoading) {
              return const CustomCircularProgressIndicator();
            } else if (status.isHasData) {
              final product =
                  state.productState.data ?? const ProductDetailDataEntity();
              return LoadingStack(
                isLoading: cartStatus.isLoading,
                widget: Stack(
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
                                  BlocBuilder<ProductDetailCubit,
                                          ProductDetailState>(
                                      builder: (context, state) {
                                    final isFavorite = state.isFavorite;
                                    return GestureDetector(
                                      onTap: () => isFavorite
                                          ? _deleteProductToFavorite(
                                              product.imageUrl)
                                          : _saveProductToFavorite(product),
                                      child: Icon(
                                        isFavorite
                                            ? Icons.star
                                            : Icons.star_border_outlined,
                                        color: ColorName.orange,
                                      ),
                                    );
                                  })
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
                                    child: CustomButton(
                                      buttonText: "Beli Langsung",
                                      buttonColor: ColorName.lightOrange,
                                      onTap:
                                          cartStatus.isLoading ? null : () {},
                                    ),
                                  ),
                                  SizedBox(width: 15.w),
                                  Expanded(
                                    child: CustomButton(
                                      buttonText: "Keranjang",
                                      buttonColor: ColorName.orange,
                                      onTap: cartStatus.isLoading
                                          ? null
                                          : () => _addProductToCart(
                                                AddToCartEntity(
                                                  productId: product.id,
                                                  amount: 1,
                                                  productName: product.name,
                                                  description:
                                                      product.description,
                                                  imageUrl: product.imageUrl,
                                                ),
                                              ),
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
                ),
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

  void _showSuccessAddToChart(AddToCartEntity data) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding:
              const EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => _closeBottomSheet(context),
                  child: const Icon(Icons.close, color: ColorName.orange),
                ),
              ),
              SizedBox(height: 16.h),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            child: CachedNetworkImage(
                              height: 54.h,
                              width: 69.w,
                              imageUrl: data.imageUrl,
                              placeholder: (context, url) => const Center(
                                  child: CustomCircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.error)),
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(width: 9.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.productName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10.sp,
                                    color: ColorName.textDarkGrey,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                HtmlWidget(
                                  data.description,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 8.sp,
                                    color: ColorName.textDarkGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      CustomButton(
                        buttonText: "Lihat Keranjang",
                        onTap: () => _productRouter.navigateToCartList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
