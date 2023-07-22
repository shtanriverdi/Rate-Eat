import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState{
  @override
  List<Object?> get props => [];
}

class LoggingIn extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessfull extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginFailed extends LoginState {
  final String error;

  LoginFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
