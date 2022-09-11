import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:onboarding/presentation/bloc/splash_bloc/splash_state.dart';
import 'package:authentication/domain/usecases/get_onboarding_status_usecase.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetOnboardingStatusUseCase getOnboardingStatusUseCase;

  SplashCubit({required this.getOnboardingStatusUseCase})
      : super(SplashState(splashState: ViewData.initial()));

  void initSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    final result = await getOnboardingStatusUseCase(const NoParams());
    result.fold(
        (failure) => emit(
              SplashState(
                splashState: ViewData.error(
                  message: failure.errorMessage,
                  failure: failure,
                ),
              ),
            ), (result) async {
      if (result) {
        emit(
          SplashState(
            splashState:
                ViewData.loaded(data: AppConstants.cachedKey.onBoardingKey),
          ),
        );
      } else {
        emit(SplashState(splashState: ViewData.noData(message: "")));
      }
    });
  }
}
