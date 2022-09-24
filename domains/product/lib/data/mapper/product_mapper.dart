import 'package:common/utils/extensions/double_extension.dart';
import 'package:common/utils/extensions/int_extension.dart';
import 'package:common/utils/extensions/list_extension.dart';
import 'package:product/data/model/response/banner_response_dto.dart';
import 'package:product/data/model/response/product_category_response_dto.dart';
import 'package:product/data/model/response/product_response_dto.dart';
import 'package:product/domain/entity/response/banner_data_entity.dart';
import 'package:product/domain/entity/response/product_category_entity.dart';
import 'package:common/utils/extensions/string_extension.dart';
import 'package:product/domain/entity/response/product_entity.dart';

class ProductMapper {
  List<ProductCategoryEntity> mapProductCategoryDtoToEntity(
      List<ProductCategoryDataDTO> data) {
    List<ProductCategoryEntity> entity = <ProductCategoryEntity>[];

    for (ProductCategoryDataDTO element in data) {
      entity.add(mapProductCategoryDataDTOToProductCategoryEntity(element));
    }
    return entity;
  }

  ProductCategoryEntity mapProductCategoryDataDTOToProductCategoryEntity(
      ProductCategoryDataDTO data) {
    return ProductCategoryEntity(
      id: data.id.orEmpty(),
      name: data.name.orEmpty(),
      imageCover: data.imageCover.orEmpty(),
      imageIcon: data.imageIcon.orEmpty(),
    );
  }

  ProductDataEntity mapProductDataDtoToProductDataEntity(ProductDataDTO data) {
    return ProductDataEntity(
        count: data.count.orNol(),
        countPerPage: data.countPerPage.orNol(),
        currentPage: data.currentPage.orNol(),
        data: mapProductDataDtoToEntity(data.data.orEmpty()));
  }

  List<ProductEntity> mapProductDataDtoToEntity(List<ProductDTO> data) {
    List<ProductEntity> entity = <ProductEntity>[];

    for (ProductDTO element in data) {
      entity.add(mapProductDtoToProductEntity(element));
    }

    return entity;
  }

  ProductEntity mapProductDtoToProductEntity(ProductDTO data) {
    return ProductEntity(
      id: data.id.orEmpty(),
      name: data.name.orEmpty(),
      seller: mapSellerDtoToSellerEntity(data.seller ?? SellerDTO()),
      stock: data.stock.orNol(),
      category: mapProductCategoryDataDTOToProductCategoryEntity(
        data.category ?? ProductCategoryDataDTO(),
      ),
      price: data.price.orNol(),
      imageUrl: data.imageUrl.orEmpty(),
      description: data.description.orEmpty(),
      soldCount: data.soldCount.orNol(),
      popularity: data.popularity.orNol(),
    );
  }

  SellerEntity mapSellerDtoToSellerEntity(SellerDTO sellerDto) {
    return SellerEntity(
      id: sellerDto.id.orEmpty(),
      name: sellerDto.name.orEmpty(),
      city: sellerDto.city.orEmpty(),
    );
  }

  List<BannerDataEntity> mapBannerDataDtoToEntity(List<BannerDataDTO> data) {
    List<BannerDataEntity> entity = <BannerDataEntity>[];

    for (BannerDataDTO element in data) {
      entity.add(mapBannerDataDtoToBannerDataEntity(element));
    }

    return entity;
  }

  BannerDataEntity mapBannerDataDtoToBannerDataEntity(BannerDataDTO data) {
    return BannerDataEntity(
      id: data.id.orEmpty(),
      name: data.name.orEmpty(),
      headline: data.headline.orEmpty(),
      caption: data.caption.orEmpty(),
      imageUrl: data.imageUrl.orEmpty(),
      sellerId: data.sellerId.orEmpty(),
      productId: data.productId.orEmpty(),
    );
  }
}
