import 'package:account/presentation/bloc/update_profile_bloc/update_profile_event.dart';
import 'package:account/presentation/bloc/update_profile_bloc/update_profile_state.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/extensions/string_extension.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/firebase/firebase.dart';
import 'package:profile/domain/entity/request/user_request_entity.dart';
import 'package:profile/domain/usecase/update_user_usecase.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateUserUseCase updateUserUseCase;
  final FirebaseMessaging firebaseMessaging;

  UpdateProfileBloc({
    required this.updateUserUseCase,
    required this.firebaseMessaging,
  }) : super(UpdateProfileState(updateUserState: ViewData.initial())) {
    /**
     * FullNameChange event bloc
     */
    on<FullNameChange>((event, emit) {
      if (event.fullName.isEmpty) {
        emit(
          UpdateProfileState(
            updateUserState: ViewData.error(
              message: AppConstants.errorKey.fullName,
              failure: FailureResponse(
                errorMessage: AppConstants.errorMessage.fullNameEmpty,
              ),
            ),
          ),
        );
      } else {
        emit(UpdateProfileState(updateUserState: ViewData.initial()));
      }
    });

    /**
     * AddressChange event bloc
     */
    on<AddressChange>((event, emit) {
      if (event.address.isEmpty) {
        emit(
          UpdateProfileState(
            updateUserState: ViewData.error(
              message: AppConstants.errorKey.address,
              failure: FailureResponse(
                errorMessage: AppConstants.errorMessage.addressEmpty,
              ),
            ),
          ),
        );
      } else {
        emit(UpdateProfileState(updateUserState: ViewData.initial()));
      }
    });

    /**
     * UpdateProfile event bloc
     */
    on<UpdateProfile>((event, emit) async {
      emit(UpdateProfileState(updateUserState: ViewData.loading()));

      if (event.fullName.isNotEmpty && event.address.isNotEmpty) {
        final fcmToken = await firebaseMessaging.getToken();
        final result = await updateUserUseCase(UserRequestEntity(
          fullName: event.fullName,
          simpleAddress: event.address,
          fcmToken: fcmToken.orEmpty(),
          fcmServerKey: AppConstants.fcmServerKey.fcmServerKey,
        ));
        result.fold(
          (failure) => emit(
            UpdateProfileState(
              updateUserState: ViewData.error(
                message: failure.errorMessage,
                failure: failure,
              ),
            ),
          ),
          (_) async =>
              emit(UpdateProfileState(updateUserState: ViewData.loaded())),
        );
      } else {
        emit(
          UpdateProfileState(
            updateUserState: ViewData.error(
              message: AppConstants.errorMessage.formNotEmpty,
              failure: FailureResponse(
                errorMessage: AppConstants.errorMessage.formNotEmpty,
              ),
            ),
          ),
        );
      }
    });
  }
}
