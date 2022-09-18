import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:authentication/domain/usecases/cache_onboarding_usecase.dart';

import 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final CacheOnboardingUseCase cacheOnboardingUseCase;

  OnBoardingCubit({required this.cacheOnboardingUseCase})
      : super(OnBoardingState(onBoardingState: ViewData.initial()));

  void saveOnBoardingStatus() async {
    final result = await cacheOnboardingUseCase(const NoParams());
    result.fold(
      (failure) => emit(
        OnBoardingState(
          onBoardingState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        OnBoardingState(
          onBoardingState: ViewData.loaded(data: result),
        ),
      ),
    );
  }
}
