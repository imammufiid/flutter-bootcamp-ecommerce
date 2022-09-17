class ProductCategoryResponseDTO {
  ProductCategoryResponseDTO({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  List<ProductCategoryDataDTO>? data;

  factory ProductCategoryResponseDTO.fromJson(Map<String, dynamic> json) =>
      ProductCategoryResponseDTO(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: List<ProductCategoryDataDTO>.from(
            json["data"].map((x) => ProductCategoryDataDTO.fromJson(x))),
      );
}

class ProductCategoryDataDTO {
  ProductCategoryDataDTO({
    this.id,
    this.name,
    this.imageCover,
    this.imageIcon,
  });

  String? id;
  String? name;
  String? imageCover;
  String? imageIcon;

  factory ProductCategoryDataDTO.fromJson(Map<String, dynamic> json) =>
      ProductCategoryDataDTO(
        id: json["id"],
        name: json["name"],
        imageCover: json["image_cover"],
        imageIcon: json["image_icon"],
      );
}
