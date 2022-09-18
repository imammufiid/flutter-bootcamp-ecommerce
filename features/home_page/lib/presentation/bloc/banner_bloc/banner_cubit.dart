import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:home_page/presentation/bloc/banner_bloc/banner_state.dart';
import 'package:product/domain/usecase/get_banner_usecase.dart';

class BannerCubit extends Cubit<BannerState> {
  final GetBannerUseCase bannerUseCase;

  BannerCubit({required this.bannerUseCase})
      : super(BannerState(bannerState: ViewData.initial()));

  void getBanners() async {
    emit(BannerState(bannerState: ViewData.loading()));
    final result = await bannerUseCase(const NoParams());
    result.fold(
      (failure) => emit(
        BannerState(
          bannerState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        BannerState(
          bannerState: ViewData.loaded(data: result),
        ),
      ),
    );
  }
}
