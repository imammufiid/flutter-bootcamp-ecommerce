import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:product/data/mapper/product_mapper.dart';
import 'package:product/data/source/remote/product_remote_source.dart';
import 'package:product/domain/entity/response/banner_data_entity.dart';
import 'package:product/domain/entity/response/product_category_entity.dart';
import 'package:product/domain/entity/response/product_entity.dart';
import 'package:product/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteSource remoteSource;
  final ProductMapper mapper;

  ProductRepositoryImpl({
    required this.remoteSource,
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
}
