import 'dart:developer';

import 'package:blog/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _useCase;
  AuthBloc({required UserSignUpUseCase useCase})
      : _useCase = useCase,
        super(AuthInitial()) {
    on<AuthSignup>((event, emit) async {
      final result = await _useCase(event.params);

      result.fold((failure) => emit(AuthFailure(message: failure.message)),
          (success) => emit(AuthSuccess(userId: success)));
    });
  }
}
