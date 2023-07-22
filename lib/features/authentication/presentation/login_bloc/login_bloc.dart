import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_yelp/features/authentication/data/repository/auth_repository.dart';
import 'package:micro_yelp/features/authentication/presentation/login_bloc/login_state.dart';

import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginSubmitted>(
      (event, emit) async {
        emit(LoggingIn());
        try {
          await authRepository.login(
              email: event.email, password: event.password);

          emit(LoginSuccessfull());
        } catch (e) {
          var error = e.toString();
          var ind = 0;
          for (var i = 0; i < error.length; i++) {
            if (error[i] == ":") {
              ind = i;
            }
          }
          error = error.substring(ind+1);

          emit(LoginFailed(error: error));
        }
      },
    );
  }
}
