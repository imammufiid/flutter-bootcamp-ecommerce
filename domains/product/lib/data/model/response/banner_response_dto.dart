class BannerResponseDto {
  BannerResponseDto({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  List<BannerDataDTO>? data;

  factory BannerResponseDto.fromJson(Map<String, dynamic> json) =>
      BannerResponseDto(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: List<BannerDataDTO>.from(json["data"].map((x) => BannerDataDTO.fromJson(x))),
      );
}

class BannerDataDTO {
  BannerDataDTO({
    this.id,
    this.name,
    this.headline,
    this.caption,
    this.imageUrl,
    this.sellerId,
    this.productId,
  });

  String? id;
  String? name;
  String? headline;
  String? caption;
  String? imageUrl;
  String? sellerId;
  String? productId;

  factory BannerDataDTO.fromJson(Map<String, dynamic> json) => BannerDataDTO(
        id: json["id"],
        name: json["name"],
        headline: json["headline"],
        caption: json["caption"],
        imageUrl: json["image_url"],
        sellerId: json["seller_id"],
        productId: json["product_id"],
      );
}
