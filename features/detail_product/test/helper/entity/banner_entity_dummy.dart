import 'package:product/data/mapper/product_mapper.dart';
import 'package:product/data/model/response/product_detail_response_dto.dart';
import 'package:product/data/model/response/product_response_dto.dart';
import 'package:product/data/model/response/seller_response_dto.dart';

import '../model/banner_response_dto_dummy.dart';

final ProductMapper productMapper = ProductMapper();

final productCategoryDummy = productMapper
    .mapProductCategoryDtoToEntity(productCategoryResponseDTODummy.data ?? []);

final productsDummy = productMapper
    .mapProductDataDtoToEntity(productResponseDTODummy.data?.data ?? []);

final productsDataDummy = productMapper.mapProductDataDtoToProductDataEntity(
    productResponseDTODummy.data ?? ProductDataDTO());

final productDetailDummy = productMapper.mapProductDetailDataDtoToEntity(
  productDetailResponseDtoDummy.data ??
      ProductDetailDataDto(
        id: null,
        name: null,
        seller: SellerDetailDto(id: null, name: null, city: null),
        stock: null,
        category: CategoryProductDetailDto(
            id: null, name: null, imageCover: null, imageIcon: null),
        price: null,
        imageUrl: null,
        description: null,
        soldCount: null,
        popularity: null,
      ),
);

final sellerDataDummy = productMapper.mapSellerDataResponseDtoToEntity(
  sellerResponseDtoDummy.data ??
      SellerDataDto(
        id: null,
        username: null,
        role: null,
        imageUrl: null,
        fullName: null,
        city: null,
        simpleAddress: null,
      ),
);
