import 'package:dependencies/equatable/equatable.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();
}

class FullNameChange extends UpdateProfileEvent {
  final String fullName;

  const FullNameChange({required this.fullName});

  @override
  List<Object?> get props => [fullName];
}

class AddressChange extends UpdateProfileEvent {
  final String address;

  const AddressChange({required this.address});

  @override
  List<Object?> get props => [address];
}

class UpdateProfile extends UpdateProfileEvent {
  final String fullName;
  final String address;

  const UpdateProfile({required this.fullName, required this.address});

  @override
  List<Object?> get props => [fullName, address];
}
