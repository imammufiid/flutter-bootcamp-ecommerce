import 'package:common/utils/extensions/string_extension.dart';
import 'package:profile/data/model/request/user_request_dto.dart';
import 'package:profile/data/model/response/user_response_dto.dart';
import 'package:profile/domain/entity/request/user_request_entity.dart';
import 'package:profile/domain/entity/response/user_entity.dart';

class ProfileMapper {
  UserEntity mapUserDataDTOToUserEntity(UserDataDTO data) => UserEntity(
        id: data.id.orEmpty(),
        username: data.username.orEmpty(),
        role: data.role.orEmpty(),
        imageUrl: data.imageUrl.orEmpty(),
        fullName: data.fullName.orEmpty(),
        city: data.city.orEmpty(),
        simpleAddress: data.simpleAddress.orEmpty(),
      );

  UserRequestDTO mapUserRequestEntityToDTO(
    UserRequestEntity userRequestEntity,
  ) =>
      UserRequestDTO(
        fullName: userRequestEntity.fullName,
        simpleAddress: userRequestEntity.simpleAddress,
        fcmToken: userRequestEntity.fcmToken,
        fcmServerKey: userRequestEntity.fcmServerKey,
      );
}
