class AuthResponseDTO {
  AuthResponseDTO({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool? status;
  int? code;
  String? message;
  AuthDataResponse? data;

  factory AuthResponseDTO.fromJson(Map<String, dynamic> json) =>
      AuthResponseDTO(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: AuthDataResponse.fromJson(json["data"]),
      );
}

class AuthDataResponse {
  AuthDataResponse({
    this.token,
  });

  String? token;

  factory AuthDataResponse.fromJson(Map<String, dynamic> json) =>
      AuthDataResponse(
        token: json["token"],
      );
}
