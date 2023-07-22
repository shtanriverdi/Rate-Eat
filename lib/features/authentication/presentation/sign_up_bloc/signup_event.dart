part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupButtonClicked extends SignupEvent {
  final String firstName, lastName, email, password;
  SignupButtonClicked(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});
}
