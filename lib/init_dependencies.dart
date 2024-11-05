import 'package:blog/core/secrets/app_secrets.dart';
import 'package:blog/feature/auth/data/datasource/remote_data_source_impl.dart';
import 'package:blog/feature/auth/data/repositories/auth_repo_impl.dart';
import 'package:blog/feature/auth/domain/usecases/user_login_usecase.dart';
import 'package:blog/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:blog/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final Supabase supBase =
      await Supabase.initialize(anonKey: anonKey, url: supBaseUrl);
  serviceLocator.registerLazySingleton(() => supBase.client);
}

_initAuth() {
  serviceLocator.registerFactory(() =>
      RemoteDataSourceImpl(supabaseClient: serviceLocator<SupabaseClient>()));
  serviceLocator.registerFactory(() => AuthRepoImpl(
      authRemoteDataSource: serviceLocator<RemoteDataSourceImpl>()));
  serviceLocator.registerFactory(
      () => UserSignUpUseCase(authRepoSitory: serviceLocator<AuthRepoImpl>()));
  serviceLocator.registerFactory(
      () => UserLoginUsecase(authRepo: serviceLocator<AuthRepoImpl>()));
  serviceLocator.registerLazySingleton(() => AuthBloc(
      userSignUpUseCase: serviceLocator<UserSignUpUseCase>(),
      userLoginUseCase: serviceLocator<UserLoginUsecase>()));
}
