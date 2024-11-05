part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class AuthSignup extends AuthEvent {
  UserSignUpParams params;
  AuthSignup({required this.params});
}

final class AuthLogin extends AuthEvent {
  UserLoginParams params;
  AuthLogin({required this.params});
}
