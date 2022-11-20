import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:product/data/mapper/product_mapper.dart';
import 'package:product/data/source/local/product_local_source.dart';
import 'package:product/data/source/remote/product_remote_source.dart';
import 'package:product/domain/entity/response/banner_data_entity.dart';
import 'package:product/domain/entity/response/product_category_entity.dart';
import 'package:product/domain/entity/response/product_detail_entity.dart';
import 'package:product/domain/entity/response/product_entity.dart';
import 'package:product/domain/entity/response/seller_data_entity.dart';
import 'package:product/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteSource remoteSource;
  final ProductLocalSource localSource;
  final ProductMapper mapper;

  ProductRepositoryImpl({
    required this.remoteSource,
    required this.localSource,
    required this.mapper,
  });

  @override
  Future<Either<FailureResponse, List<BannerDataEntity>>> getBanners() async {
    try {
      final response = await remoteSource.getBanners();
      return Right(mapper.mapBannerDataDtoToEntity(response.data!));
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, List<ProductCategoryEntity>>>
      getProductCategories() async {
    try {
      final response = await remoteSource.getProductCategories();
      return Right(mapper.mapProductCategoryDtoToEntity(response.data!));
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, ProductDataEntity>> getProducts() async {
    try {
      final response = await remoteSource.getProducts();
      return Right(mapper.mapProductDataDtoToProductDataEntity(response.data!));
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, ProductDetailDataEntity>> getProductDetail(
      String productId) async {
    try {
      final response = await remoteSource.getProductDetail(productId);
      return Right(mapper.mapProductDetailDataDtoToEntity(response.data!));
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, SellerDataEntity>> getSeller(
      String sellerId) async {
    try {
      final response = await remoteSource.getSeller(sellerId);
      return Right(mapper.mapSellerDataResponseDtoToEntity(response.data!));
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }

  @override
  Stream<List<ProductDetailDataEntity>> getFavProducts() {
    return localSource
        .getFavProducts()
        .map((event) => mapper.mapListProductDetailTableDataToEntity(event));
  }

  @override
  Future<Either<FailureResponse, bool>> save(
      ProductDetailDataEntity data) async {
    try {
      final result = await localSource
          .save(mapper.mapProductDetailEntityToCompanion(data));
      return Right(result);
    } catch (error) {
      return Left(FailureResponse(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, bool>> deleteProduct(String productUrl) async {
    try {
      final response = await localSource.deleteProduct(productUrl);
      return Right(response);
    } catch (error) {
      return Left(FailureResponse(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, ProductDetailDataEntity>>
      getFavoriteProductByUrl(String productUrl) async {
    try {
      final response = await localSource.getFavoriteProductByUrl(productUrl);
      final data = mapper.mapProductDetailTableToEntity(response);
      return Right(data);
    } catch (error) {
      return Left(FailureResponse(errorMessage: error.toString()));
    }
  }
}
