import 'package:common/utils/extensions/double_extension.dart';
import 'package:common/utils/extensions/int_extension.dart';
import 'package:common/utils/extensions/list_extension.dart';
import 'package:core/local/database/database_module.dart';
import 'package:dependencies/drift/drift.dart';
import 'package:product/data/model/response/banner_response_dto.dart';
import 'package:product/data/model/response/product_category_response_dto.dart';
import 'package:product/data/model/response/product_detail_response_dto.dart';
import 'package:product/data/model/response/product_response_dto.dart';
import 'package:product/data/model/response/seller_response_dto.dart';
import 'package:product/domain/entity/response/banner_data_entity.dart';
import 'package:product/domain/entity/response/product_category_entity.dart';
import 'package:common/utils/extensions/string_extension.dart';
import 'package:product/domain/entity/response/product_detail_entity.dart';
import 'package:product/domain/entity/response/product_entity.dart';
import 'package:product/domain/entity/response/seller_data_entity.dart';

class ProductMapper {
  ProductDetailDataEntity mapProductDetailTableDataToEntity(
      ProductDetailTableData data) {
    return ProductDetailDataEntity(name: data.name, imageUrl: data.imageUrl);
  }

  List<ProductDetailDataEntity> mapListProductDetailTableDataToEntity(
      List<ProductDetailTableData> data) {
    List<ProductDetailDataEntity> entity = <ProductDetailDataEntity>[];
    for (ProductDetailTableData e in data) {
      entity.add(mapProductDetailTableDataToEntity(e));
    }
    return entity;
  }

  ProductDetailTableCompanion mapProductDetailEntityToCompanion(
      ProductDetailDataEntity data) {
    return ProductDetailTableCompanion(
      name: Value(data.name),
      stock: Value(data.stock),
      price: Value(data.price),
      imageUrl: Value(data.imageUrl),
      description: Value(data.description),
      soldCount: Value(data.soldCount),
      popularity: Value(data.popularity),
    );
  }

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

  ProductDetailDataEntity mapProductDetailDataDtoToEntity(
          ProductDetailDataDto dto) =>
      ProductDetailDataEntity(
        id: dto.id ?? "",
        name: dto.name ?? "",
        seller: mapSellerDetailDtoToEntity(dto.seller),
        stock: dto.stock ?? 0,
        category: mapCategoryProductDetailDtoToEntity(dto.category),
        price: dto.price ?? 0,
        imageUrl: dto.imageUrl ?? "",
        description: dto.description ?? "",
        soldCount: dto.soldCount ?? 0,
        popularity: dto.popularity ?? 0.0,
      );

  CategoryProductDetailEntity mapCategoryProductDetailDtoToEntity(
          CategoryProductDetailDto dto) =>
      CategoryProductDetailEntity(
        id: dto.id ?? "",
        name: dto.name ?? "",
        imageCover: dto.imageCover ?? "",
        imageIcon: dto.imageIcon ?? "",
      );

  SellerDetailEntity mapSellerDetailDtoToEntity(SellerDetailDto dto) =>
      SellerDetailEntity(
        id: dto.id ?? "",
        name: dto.name ?? "",
        city: dto.city ?? "",
      );

  SellerDataEntity mapSellerDataResponseDtoToEntity(SellerDataDto dto) =>
      SellerDataEntity(
        id: dto.id ?? "",
        username: dto.username ?? "",
        role: dto.role ?? "",
        imageUrl: dto.imageUrl ?? "",
        fullName: dto.fullName ?? "",
        city: dto.city ?? "",
        simpleAddress: dto.simpleAddress ?? "",
      );

  ProductDetailDataEntity mapProductDetailTableToEntity(
      ProductDetailTableData table) {
    return ProductDetailDataEntity(
      name: table.name,
      stock: table.stock,
      price: table.price,
      imageUrl: table.imageUrl,
      description: table.description,
      soldCount: table.soldCount,
      popularity: table.popularity,
    );
  }

  ProductDetailTableCompanion mapProductDetailDataEntityToTable(
      ProductDetailDataEntity entity) {
    return ProductDetailTableCompanion(
      name: Value(entity.name),
      stock: Value(entity.stock),
      price: Value(entity.price),
      imageUrl: Value(entity.imageUrl),
      description: Value(entity.description),
      soldCount: Value(entity.soldCount),
      popularity: Value(entity.popularity),
    );
  }
}
