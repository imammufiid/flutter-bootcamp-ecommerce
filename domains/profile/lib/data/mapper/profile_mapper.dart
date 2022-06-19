import 'package:profile/data/model/request/user_request_dto.dart';
import 'package:profile/data/model/response/user_response_dto.dart';
import 'package:profile/domain/entity/request/user_request_entity.dart';
import 'package:profile/domain/entity/response/user_entity.dart';

class ProfileMapper {
  UserEntity mapUserDataDTOToUserEntity(UserDataDTO userDataDTO) => UserEntity(
        username: userDataDTO.username ?? "",
        id: userDataDTO.id ?? "",
        imageUrl: userDataDTO.imageUrl ?? "",
        city: userDataDTO.city ?? "",
        simpleAddress: userDataDTO.simpleAddress ?? "",
        fullName: userDataDTO.fullName ?? "",
        role: userDataDTO.role ?? "",
      );

  UserRequestDto mapUserRequestEntityToDTO(
          UserRequestEntity userRequestEntity) =>
      UserRequestDto(
        fullName: userRequestEntity.fullName,
        simpleAddress: userRequestEntity.simpleAddress,
        fcmToken: userRequestEntity.fcmToken,
        fcmServerKey: userRequestEntity.fcmServerKey,
      );
}
