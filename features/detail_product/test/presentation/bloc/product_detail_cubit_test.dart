import 'package:bloc_test/bloc_test.dart';
import 'package:cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:detail_product/presentation/bloc/product_detail_bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product/domain/usecase/get_product_detail_usecase.dart';
import 'package:product/domain/usecase/get_seller_usecase.dart';

import '../../helper/entity/banner_entity_dummy.dart';

void main() => testProductDetail();

class MockGetProductDetailUseCase extends Mock
    implements GetProductDetailUseCase {}

class MockGetSellerUseCase extends Mock implements GetSellerUseCase {}

class MockAddToCartUseCase extends Mock implements AddToCartUseCase {}

void testProductDetail() {
  late final GetProductDetailUseCase mockGetProductDetailUseCase;
  late final GetSellerUseCase mockGetSellerUseCase;
  late final MockAddToCartUseCase mockAddToCartUseCase;

  setUpAll(() {
    mockGetProductDetailUseCase = MockGetProductDetailUseCase();
    mockGetSellerUseCase = MockGetSellerUseCase();
    mockAddToCartUseCase = MockAddToCartUseCase();
  });

  group('Product Detail Cubit', () {
    blocTest<ProductDetailCubit, ProductDetailState>(
      'emits [] when nothing is added',
      build: () => ProductDetailCubit(
        getProductDetailUseCase: mockGetProductDetailUseCase,
        getSellerUseCase: mockGetSellerUseCase,
        addToCartUseCase: mockAddToCartUseCase,
      ),
      expect: () => [],
    );

    blocTest<ProductDetailCubit, ProductDetailState>(
      '''emits 
        [
          ProductDetailState(productState: loading, sellerState: initial),
          ProductDetailState(productState: loaded, sellerState: initial),
          ProductDetailState(productState: loaded, sellerState: loading),
          ProductDetailState(productState: loaded, sellerState: loaded),
        ] 
      when getProductDetail is call''',
      build: () {
        when(() => mockGetProductDetailUseCase.call(any()))
            .thenAnswer((_) async => Right(productDetailDummy));

        when(() => mockGetSellerUseCase.call(any()))
            .thenAnswer((_) async => Right(sellerDataDummy));

        return ProductDetailCubit(
          getProductDetailUseCase: mockGetProductDetailUseCase,
          getSellerUseCase: mockGetSellerUseCase,
          addToCartUseCase: mockAddToCartUseCase,
        );
      },
      act: (ProductDetailCubit bloc) => bloc.getProduct("1"),
      expect: () => [
        ProductDetailState(
          productState: ViewData.loading(),
          sellerState: ViewData.initial(),
          addToCartState: ViewData.initial(),
        ),
        ProductDetailState(
          productState: ViewData.loaded(data: productDetailDummy),
          sellerState: ViewData.initial(),
          addToCartState: ViewData.initial(),
        ),
        ProductDetailState(
          productState: ViewData.loaded(data: productDetailDummy),
          sellerState: ViewData.loading(),
          addToCartState: ViewData.initial(),
        ),
        ProductDetailState(
          productState: ViewData.loaded(data: productDetailDummy),
          sellerState: ViewData.loaded(data: sellerDataDummy),
          addToCartState: ViewData.initial(),
        ),
      ],
    );

    blocTest<ProductDetailCubit, ProductDetailState>(
      '''emits 
        [
          ProductDetailState(productState: loading, sellerState: initial),
          ProductDetailState(productState: error, sellerState: initial),
        ] 
      when getProductDetail is call''',
      build: () {
        when(() => mockGetProductDetailUseCase.call(any())).thenAnswer(
            (_) async => const Left(FailureResponse(errorMessage: '')));

        return ProductDetailCubit(
          getProductDetailUseCase: mockGetProductDetailUseCase,
          getSellerUseCase: mockGetSellerUseCase,
          addToCartUseCase: mockAddToCartUseCase,
        );
      },
      act: (ProductDetailCubit bloc) => bloc.getProduct("1"),
      expect: () => [
        ProductDetailState(
          productState: ViewData.loading(),
          sellerState: ViewData.initial(),
          addToCartState: ViewData.initial(),
        ),
        ProductDetailState(
          productState: ViewData.error(
            message: '',
            failure: const FailureResponse(errorMessage: ''),
          ),
          sellerState: ViewData.initial(),
          addToCartState: ViewData.initial(),
        ),
      ],
    );

    blocTest<ProductDetailCubit, ProductDetailState>(
      '''emits 
        [
          ProductDetailState(productState: loading, sellerState: initial),
          ProductDetailState(productState: loaded, sellerState: initial),
          ProductDetailState(productState: loaded, sellerState: loading),
          ProductDetailState(productState: loaded, sellerState: error),
        ] 
      when getProductDetail is call''',
      build: () {
        when(() => mockGetProductDetailUseCase.call(any()))
            .thenAnswer((_) async => Right(productDetailDummy));

        when(() => mockGetSellerUseCase.call(any())).thenAnswer(
            (_) async => const Left(FailureResponse(errorMessage: '')));

        return ProductDetailCubit(
          getProductDetailUseCase: mockGetProductDetailUseCase,
          getSellerUseCase: mockGetSellerUseCase,
          addToCartUseCase: mockAddToCartUseCase,
        );
      },
      act: (ProductDetailCubit bloc) => bloc.getProduct("1"),
      expect: () => [
        ProductDetailState(
          productState: ViewData.loading(),
          sellerState: ViewData.initial(),
          addToCartState: ViewData.initial(),
        ),
        ProductDetailState(
          productState: ViewData.loaded(data: productDetailDummy),
          sellerState: ViewData.initial(),
          addToCartState: ViewData.initial(),
        ),
        ProductDetailState(
          productState: ViewData.loaded(data: productDetailDummy),
          sellerState: ViewData.loading(),
          addToCartState: ViewData.initial(),
        ),
        ProductDetailState(
          productState: ViewData.loaded(data: productDetailDummy),
          sellerState: ViewData.error(
            message: '',
            failure: const FailureResponse(errorMessage: ''),
          ),
          addToCartState: ViewData.initial(),
        ),
      ],
    );
  });
}
