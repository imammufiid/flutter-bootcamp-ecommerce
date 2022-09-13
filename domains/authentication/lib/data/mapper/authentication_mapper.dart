import 'package:authentication/data/model/body/auth_request_dto.dart';
import 'package:authentication/data/model/response/auth_response_dto.dart';
import 'package:authentication/domain/entity/body/auth_request_entity.dart';
import 'package:authentication/domain/entity/body/auth_response_entity.dart';

class AuthenticationMapper {
  AuthRequestDTO mapAuthRequestEntityToAuthRequestDTO(
          AuthRequestEntity authRequestEntity) =>
      AuthRequestDTO(
          username: authRequestEntity.username,
          password: authRequestEntity.username);

  AuthResponseEntity mapAuthResponseDTOToAuthResponseEntity(
          AuthResponseDTO authResponseDTO) =>
      AuthResponseEntity(token: authResponseDTO.data?.token ?? "");
}
