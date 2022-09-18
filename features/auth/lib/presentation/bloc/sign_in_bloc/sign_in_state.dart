part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  final ViewData<bool> signInState;

  const SignInState({required this.signInState});

  SignInState copyWith({
    ViewData<bool>? signInState,
  }) {
    return SignInState(signInState: signInState ?? this.signInState);
  }

  @override
  List<Object?> get props => [signInState];
}
