import 'dart:convert';

import 'package:product/data/model/response/product_category_response_dto.dart';
import 'package:product/data/model/response/product_detail_response_dto.dart';
import 'package:product/data/model/response/product_response_dto.dart';
import 'package:product/data/model/response/seller_response_dto.dart';

import '../json_reader.dart';

final resultProductCategoryDummyJson = json.decode(
  TestHelper.readJson('helper/json/product_categories.json'),
);

final resultProductsDummyJson = json.decode(
  TestHelper.readJson('helper/json/products.json'),
);

final resultProductDetailDummyJson = json.decode(
  TestHelper.readJson('helper/json/product_detail.json'),
);

final resultSellerDummyJson = json.decode(
  TestHelper.readJson('helper/json/seller.json'),
);

final ProductCategoryResponseDTO productCategoryResponseDTODummy =
    ProductCategoryResponseDTO.fromJson(resultProductCategoryDummyJson);

final ProductResponseDTO productResponseDTODummy =
    ProductResponseDTO.fromJson(resultProductsDummyJson);

final ProductDetailResponseDto productDetailResponseDtoDummy =
    ProductDetailResponseDto.fromJson(resultProductDetailDummyJson);

final SellerResponseDto sellerResponseDtoDummy =
    SellerResponseDto.fromJson(resultSellerDummyJson);
