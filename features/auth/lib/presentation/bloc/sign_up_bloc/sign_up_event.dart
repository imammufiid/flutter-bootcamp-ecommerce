import 'package:authentication/domain/entity/body/auth_request_entity.dart';
import 'package:dependencies/equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class UsernameChange extends SignUpEvent {
  final String username;

  const UsernameChange({required this.username});

  @override
  List<Object?> get props => [username];
}

class PasswordChange extends SignUpEvent {
  final String password;

  const PasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class PasswordConfirmationChange extends SignUpEvent {
  final String password;
  final String passwordConfirmation;

  const PasswordConfirmationChange({
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object?> get props => [password, passwordConfirmation];
}

class SignUp extends SignUpEvent {
  final AuthRequestEntity authRequestEntity;

  const SignUp({required this.authRequestEntity});

  @override
  List<Object?> get props => [authRequestEntity];
}
