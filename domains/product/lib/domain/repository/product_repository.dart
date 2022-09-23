import 'package:common/utils/error/failure_response.dart';
import 'package:product/domain/entity/response/banner_data_entity.dart';
import 'package:product/domain/entity/response/product_category_entity.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:product/domain/entity/response/product_detail_entity.dart';
import 'package:product/domain/entity/response/product_entity.dart';
import 'package:product/domain/entity/response/seller_data_entity.dart';

abstract class ProductRepository {
  const ProductRepository();

  Future<Either<FailureResponse, List<ProductCategoryEntity>>>
      getProductCategories();

  Future<Either<FailureResponse, ProductDataEntity>> getProducts();

  Future<Either<FailureResponse, List<BannerDataEntity>>> getBanners();

  Future<Either<FailureResponse, ProductDetailDataEntity>>
      getProductDetail(String productId);

  Future<Either<FailureResponse, SellerDataEntity>> getSeller(
      String sellerId);
}
