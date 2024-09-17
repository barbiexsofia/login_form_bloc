part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {
  final String uid;
  // userModel if i have one

  AuthSuccess({required this.uid});
}

final class AuthFailure extends AuthState {
  final List<String> errorMsg;

  AuthFailure(this.errorMsg);
}

final class AuthLoading extends AuthState {}
