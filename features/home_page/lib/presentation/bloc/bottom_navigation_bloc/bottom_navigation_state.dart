import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/equatable/equatable.dart';

class BottomNavigationState extends Equatable {
  final ViewData<int> homeState;

  const BottomNavigationState({required this.homeState});

  BottomNavigationState copyWith({ViewData<int>? homeState}) {
    return BottomNavigationState(homeState: homeState ?? this.homeState);
  }

  @override
  List<Object?> get props => [homeState];
}
