part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {}

class SignupInitial extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignupSuccessful extends SignupState {
  @override
  List<Object?> get props => [];
}

class SigningUserUp extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignupFailed extends SignupState {
  final String error;

  SignupFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
