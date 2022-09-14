import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/equatable/equatable.dart';

class SignUpState extends Equatable {
  final ViewData<bool> signUpState;

  const SignUpState({required this.signUpState});

  SignUpState copyWith({
    ViewData<bool>? signUpState,
  }) {
    return SignUpState(signUpState: signUpState ?? this.signUpState);
  }

  @override
  List<Object?> get props => [signUpState];
}
