import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        // check for validity of email & passwords.
        final email = event.email;
        final password = event.password;
        final List<String> errorMsg = [];
        if (password.length < 6) {
          errorMsg.add('Password cannot be less that 6 characters.');
        }
        if (!email.contains("@")) {
          errorMsg.add('Email not valid.');
        }

        if (errorMsg.isEmpty) {
          await Future.delayed(const Duration(seconds: 1), () {
            return emit(AuthSuccess(uid: '$email-$password'));
          });
          print("all ok!");
        } else {
          for (var e in errorMsg) {
            print(e);
          }
          return emit(AuthFailure(errorMsg));
        }
      } catch (e) {
        print(e);
        return emit(AuthFailure([e.toString()]));
      }
    });
  }
}
