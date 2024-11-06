import 'package:blog/core/common/cubit/app_user_cubit.dart';
import 'package:blog/core/entities/user.dart';
import 'package:blog/core/usecase/use_case.dart';
import 'package:blog/feature/auth/domain/usecases/user_login_usecase.dart';
import 'package:blog/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/user_get_data_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _userSignUpUseCase;
  final UserLoginUsecase _userLoginUseCase;
  final UserGetDataUsecase _userGetDataUsecase;
  final AppUserCubit _appUserCubit;
  AuthBloc(
      {required UserSignUpUseCase userSignUpUseCase,
      required UserLoginUsecase userLoginUseCase,
      required AppUserCubit appUserCubit,
      required UserGetDataUsecase userGetDataUsecase})
      : _userSignUpUseCase = userSignUpUseCase,
        _userLoginUseCase = userLoginUseCase,
        _userGetDataUsecase = userGetDataUsecase,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>(
      (_, emit) => emit(AuthLoading()),
    );
    on<AuthSignup>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<IsUserLoggedIn>(_onIsUserSignedIn);
  }
  void _onAuthSignUp(AuthSignup event, Emitter<AuthState> emit) async {
    final result = await _userSignUpUseCase(event.params);
    result.fold((failure) => emit(AuthFailure(message: failure.message)),
        (success) => _emitAuthSuccess(success, emit));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final result = await _userLoginUseCase(event.params);
    result.fold((failure) => emit(AuthFailure(message: failure.message)),
        (success) => _emitAuthSuccess(success, emit));
  }

  void _onIsUserSignedIn(IsUserLoggedIn event, Emitter<AuthState> emit) async {
    final result = await _userGetDataUsecase(NoParam());
    result.fold((failure) => emit(AuthFailure(message: failure.message)),
        (success) => _emitAuthSuccess(success, emit));
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
