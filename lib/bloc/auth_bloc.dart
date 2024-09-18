import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print('AuthBloc - Change - $change');
    if (change.currentState is AuthLoading && change.nextState is AuthFailure) {
      print('something went wrong and couldn\'t log in');
    }
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    print('AuthBloc - Transition - $transition');
  }

  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   // TODO: implement onError
  //   super.onError(error, stackTrace);
  // }

  void _onAuthLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
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
  }

  void _onAuthLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 1), () {
        return emit(AuthInitial());
      });
    } catch (e) {
      emit(AuthFailure([e.toString()]));
    }
  }
}
