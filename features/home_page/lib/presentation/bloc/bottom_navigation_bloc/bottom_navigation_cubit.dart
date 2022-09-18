import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:home_page/presentation/bloc/bottom_navigation_bloc/bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationState(homeState: ViewData.loaded(data: 0)));

  void changeTab({required int tabIndex}) =>
      emit(BottomNavigationState(homeState: ViewData.loaded(data: tabIndex)));
}
