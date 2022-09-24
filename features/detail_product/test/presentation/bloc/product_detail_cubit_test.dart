import 'package:bloc_test/bloc_test.dart';
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

void testProductDetail() {
  late final GetProductDetailUseCase mockGetProductDetailUseCase;
  late final GetSellerUseCase mockGetSellerUseCase;

  setUpAll(() {
    mockGetProductDetailUseCase = MockGetProductDetailUseCase();
    mockGetSellerUseCase = MockGetSellerUseCase();
  });

  group('Product Detail Cubit', () {
    blocTest<ProductDetailCubit, ProductDetailState>(
      'emits [] when nothing is added',
      build: () => ProductDetailCubit(
        getProductDetailUseCase: mockGetProductDetailUseCase,
        getSellerUseCase: mockGetSellerUseCase,
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
        );
      },
      act: (ProductDetailCubit bloc) => bloc.getProduct("1"),
      expect: () => [
        ProductDetailState(
            productState: ViewData.loading(), sellerState: ViewData.initial()),
        ProductDetailState(
          productState: ViewData.loaded(data: productDetailDummy),
          sellerState: ViewData.initial(),
        ),
        ProductDetailState(
          productState: ViewData.loaded(data: productDetailDummy),
          sellerState: ViewData.loading(),
        ),
        ProductDetailState(
          productState: ViewData.loaded(data: productDetailDummy),
          sellerState: ViewData.loaded(data: sellerDataDummy),
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
        );
      },
      act: (ProductDetailCubit bloc) => bloc.getProduct("1"),
      expect: () => [
        ProductDetailState(
            productState: ViewData.loading(), sellerState: ViewData.initial()),
        ProductDetailState(
          productState: ViewData.error(
            message: '',
            failure: const FailureResponse(errorMessage: ''),
          ),
          sellerState: ViewData.initial(),
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
        );
      },
      act: (ProductDetailCubit bloc) => bloc.getProduct("1"),
      expect: () => [
        ProductDetailState(
            productState: ViewData.loading(), sellerState: ViewData.initial()),
        ProductDetailState(
          productState: ViewData.loaded(data: productDetailDummy),
          sellerState: ViewData.initial(),
        ),
        ProductDetailState(
          productState: ViewData.loaded(data: productDetailDummy),
          sellerState: ViewData.loading(),
        ),
        ProductDetailState(
          productState: ViewData.loaded(data: productDetailDummy),
          sellerState: ViewData.error(
            message: '',
            failure: const FailureResponse(errorMessage: ''),
          ),
        ),
      ],
    );
  });
}
