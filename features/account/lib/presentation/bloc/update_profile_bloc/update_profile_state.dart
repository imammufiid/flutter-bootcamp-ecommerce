import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/equatable/equatable.dart';
import 'package:profile/domain/entity/response/user_entity.dart';

class UpdateProfileState extends Equatable {
  final ViewData<UserEntity> updateUserState;

  const UpdateProfileState({required this.updateUserState});

  UpdateProfileState copyWith({ViewData<UserEntity>? updateUserState}) {
    return UpdateProfileState(
        updateUserState: updateUserState ?? this.updateUserState);
  }

  @override
  List<Object?> get props => [updateUserState];
}
