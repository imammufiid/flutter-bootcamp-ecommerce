import 'dart:io';

import 'package:common/utils/constants/app_constants.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:profile/data/model/request/user_request_dto.dart';
import 'package:profile/data/model/response/user_response_dto.dart';

abstract class ProfileRemoteSource {
  const ProfileRemoteSource();

  Future<UserResponseDTO> getUser();

  Future<UserResponseDTO> updateUserData({
    required UserRequestDTO userRequestDTO,
  });

  Future<UserResponseDTO> uploadPhoto({required File image});
}

class ProfileRemoteSourceImpl extends ProfileRemoteSource {
  final Dio dio;

  ProfileRemoteSourceImpl({required this.dio});

  @override
  Future<UserResponseDTO> getUser() async {
    try {
      final response = await dio.get(AppConstants.appApi.user);
      return UserResponseDTO.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserResponseDTO> updateUserData({
    required UserRequestDTO userRequestDTO,
  }) async {
    try {
      final response = await dio.put(
        AppConstants.appApi.user,
        data: userRequestDTO.toJson(),
      );
      return UserResponseDTO.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserResponseDTO> uploadPhoto({required File image}) async {
    try {
      String fileName = image.path.split("/").last;
      var formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: MediaType("image", "png"),
        ),
      });

      final response = await dio.put(
        AppConstants.appApi.updateUserImage,
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
      );
      return UserResponseDTO.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }
}
