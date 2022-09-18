import 'product_category_response_dto.dart';

class ProductResponseDTO {
  ProductResponseDTO({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  ProductDataDTO? data;

  factory ProductResponseDTO.fromJson(Map<String, dynamic> json) =>
      ProductResponseDTO(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: ProductDataDTO.fromJson(json["data"]),
      );
}

class ProductDataDTO {
  ProductDataDTO({
    this.count,
    this.countPerPage,
    this.currentPage,
    this.data,
  });

  int? count;
  int? countPerPage;
  int? currentPage;
  List<ProductDTO>? data;

  factory ProductDataDTO.fromJson(Map<String, dynamic> json) => ProductDataDTO(
        count: json["count"],
        countPerPage: json["count_per_page"],
        currentPage: json["current_page"],
        data: List<ProductDTO>.from(json["data"].map((x) => ProductDTO.fromJson(x))),
      );
}

class ProductDTO {
  ProductDTO({
    this.id,
    this.name,
    this.seller,
    this.stock,
    this.category,
    this.price,
    this.imageUrl,
    this.description,
    this.soldCount,
    this.popularity,
  });

  String? id;
  String? name;
  SellerDTO? seller;
  int? stock;
  ProductCategoryDataDTO? category;
  int? price;
  String? imageUrl;
  String? description;
  int? soldCount;
  double? popularity;

  factory ProductDTO.fromJson(Map<String, dynamic> json) => ProductDTO(
        id: json["id"],
        name: json["name"],
        seller: SellerDTO.fromJson(json["seller"]),
        stock: json["stock"],
        category: ProductCategoryDataDTO.fromJson(json["category"]),
        price: json["price"],
        imageUrl: json["image_url"],
        description: json["description"],
        soldCount: json["sold_count"],
        popularity: json["popularity"].toDouble(),
      );
}

class SellerDTO {
  SellerDTO({
    this.id,
    this.name,
    this.city,
  });

  String? id;
  String? name;
  String? city;

  factory SellerDTO.fromJson(Map<String, dynamic> json) => SellerDTO(
        id: json["id"],
        name: json["name"],
        city: json["city"],
      );
}
