import 'package:authentication/data/model/body/auth_request_dto.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:dependencies/dio/dio.dart';

import '../../model/response/auth_response_dto.dart';

abstract class AuthenticationRemoteSource {
  const AuthenticationRemoteSource();

  Future<AuthResponseDTO> signUp({required AuthRequestDTO authRequestDto});

  Future<AuthResponseDTO> signIn({required AuthRequestDTO authRequestDto});
}

class AuthenticationRemoteSourceImpl implements AuthenticationRemoteSource {
  final Dio dio;

  AuthenticationRemoteSourceImpl({required this.dio});

  @override
  Future<AuthResponseDTO> signIn(
      {required AuthRequestDTO authRequestDto}) async {
    try {
      final response = await dio.post(
        AppConstants.appApi.signIn,
        data: authRequestDto.toJson(),
      );
      return AuthResponseDTO.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponseDTO> signUp(
      {required AuthRequestDTO authRequestDto}) async {
    try {
      final response = await dio.post(
        AppConstants.appApi.signUp,
        data: authRequestDto.toJson(),
      );
      return AuthResponseDTO.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
