import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_yelp/features/authentication/data/repository/auth_repository.dart';

import '../../data/models/user_model.dart';
import '../../data/authentication_data.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepository;

  SignupBloc({required this.authRepository}) : super(SignupInitial()) {
    on<SignupButtonClicked>((event, emit) async {
      emit(SigningUserUp());
      User user = User(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
      );

      try {
        await authRepository.signUp(user: user);
        emit(SignupSuccessful());
      } catch (e) {
        emit(SignupFailed(error: e.toString()));
      }
    });
  }
}
