import 'package:blog/feature/auth/domain/entities/user.dart';
import 'package:blog/feature/auth/domain/usecases/user_login_usecase.dart';
import 'package:blog/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _userSignUpUseCase;
  final UserLoginUsecase _userLoginUseCase;
  AuthBloc(
      {required UserSignUpUseCase userSignUpUseCase,
      required UserLoginUsecase userLoginUseCase})
      : _userSignUpUseCase = userSignUpUseCase,
        _userLoginUseCase = userLoginUseCase,
        super(AuthInitial()) {
    on<AuthSignup>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
  }
  void _onAuthSignUp(AuthSignup event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _userSignUpUseCase(event.params);
    result.fold((failure) => emit(AuthFailure(message: failure.message)),
        (success) => emit(AuthSuccess(user: success)));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _userLoginUseCase(event.params);
    result.fold((failure) => emit(AuthFailure(message: failure.message)),
        (success) => emit(AuthSuccess(user: success)));
  }
}
