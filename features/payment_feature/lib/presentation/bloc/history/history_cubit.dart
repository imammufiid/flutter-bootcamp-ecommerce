import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:payment/domain/entity/response/product_history_entity.dart';
import 'package:payment/domain/usecase/get_history_usercase.dart';
import 'package:payment_feature/presentation/bloc/history/history_state.dart';
import 'package:payment_feature/presentation/bloc/history/bloc.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetHistoryUseCase getHistoryUseCase;

  HistoryCubit({
    required this.getHistoryUseCase,
  }) : super(HistoryState(
          historyState: ViewData.initial(),
        ));

  void getHistory() async {
    emit(state.copyWith(historyState: ViewData.loading(message: "Loading..")));
    final result = await getHistoryUseCase.call(const NoParams());
    return result.fold(
      (failure) => _onFailureGetHistory(failure),
      (result) => _onSuccessGetHistory(result),
    );
  }

  Future<void> _onFailureGetHistory(
    FailureResponse failure,
  ) async {
    emit(state.copyWith(
        historyState:
            ViewData.error(message: failure.errorMessage, failure: failure)));
  }

  Future<void> _onSuccessGetHistory(
    HistoryEntity data,
  ) async {
    if (data.data.isEmpty) {
      emit(state.copyWith(historyState: ViewData.noData(message: "No Data")));
    } else {
      emit(state.copyWith(historyState: ViewData.loaded(data: data)));
    }
  }
}
