import 'package:common/utils/constants/app_constants.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:product/data/model/response/banner_response_dto.dart';
import 'package:product/data/model/response/product_category_response_dto.dart';
import 'package:product/data/model/response/product_response_dto.dart';

abstract class ProductRemoteSource {
  const ProductRemoteSource();

  Future<ProductCategoryResponseDTO> getProductCategories();

  Future<ProductResponseDTO> getProducts();

  Future<BannerResponseDto> getBanners();
}

class ProductRemoteSourceImpl extends ProductRemoteSource {
  final Dio dio;

  ProductRemoteSourceImpl({required this.dio});

  @override
  Future<BannerResponseDto> getBanners() async {
    try {
      final response = await dio.get(AppConstants.appApi.banner);
      return BannerResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductResponseDTO> getProducts() async {
    try {
      final response = await dio.get(AppConstants.appApi.product);
      return ProductResponseDTO.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductCategoryResponseDTO> getProductCategories() async {
    try {
      final response = await dio.get(AppConstants.appApi.category);
      return ProductCategoryResponseDTO.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
