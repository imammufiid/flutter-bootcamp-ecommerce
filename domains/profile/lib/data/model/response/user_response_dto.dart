class UserResponseDTO {
  UserResponseDTO({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  UserDataDTO? data;

  factory UserResponseDTO.fromJson(Map<String, dynamic> json) =>
      UserResponseDTO(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: UserDataDTO.fromJson(json["data"]),
      );
}

class UserDataDTO {
  UserDataDTO({
    this.id,
    this.username,
    this.role,
    this.imageUrl,
    this.fullName,
    this.city,
    this.simpleAddress,
  });

  String? id;
  String? username;
  String? role;
  String? imageUrl;
  String? fullName;
  String? city;
  String? simpleAddress;

  factory UserDataDTO.fromJson(Map<String, dynamic> json) => UserDataDTO(
        id: json["id"],
        username: json["username"],
        role: json["role"],
        imageUrl: json["image_url"],
        fullName: json["full_name"],
        city: json["city"],
        simpleAddress: json["simple_address"],
      );
}
