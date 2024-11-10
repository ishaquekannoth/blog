import 'package:blog/core/common/cubit/app_user_cubit.dart';
import 'package:blog/core/network/connection_checker.dart';
import 'package:blog/core/secrets/app_secrets.dart';
import 'package:blog/feature/auth/data/datasource/remote_data_source_impl.dart';
import 'package:blog/feature/auth/data/repositories/auth_repo_impl.dart';
import 'package:blog/feature/auth/domain/usecases/user_get_data_usecase.dart';
import 'package:blog/feature/auth/domain/usecases/user_login_usecase.dart';
import 'package:blog/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:blog/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/feature/blog/data/data_source/blog_local_data_source_impl.dart';
import 'package:blog/feature/blog/data/data_source/blog_remote_data_source_impl.dart';
import 'package:blog/feature/blog/data/data_source/data_base_helper.dart';
import 'package:blog/feature/blog/data/repositories/blog_repo_impl.dart';
import 'package:blog/feature/blog/domain/use_cases/get_all_blogs_use_case.dart';
import 'package:blog/feature/blog/domain/use_cases/upload_blog_usecase.dart';
import 'package:blog/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final Supabase supBase =
      await Supabase.initialize(anonKey: anonKey, url: supBaseUrl);
  serviceLocator.registerLazySingleton(() => supBase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => ConnectionCheckerImpl(
      internetConnectionChecker: serviceLocator<InternetConnection>()));
  serviceLocator.registerFactory(
      () => BlogLocalDataSourceImpl(databaseHelper: DatabaseHelper()));
}

_initAuth() {
  serviceLocator.registerFactory(() =>
      RemoteDataSourceImpl(supabaseClient: serviceLocator<SupabaseClient>()));

  serviceLocator.registerFactory(() => AuthRepoImpl(
      connectionChecker: serviceLocator<ConnectionCheckerImpl>(),
      authRemoteDataSource: serviceLocator<RemoteDataSourceImpl>()));
  serviceLocator.registerFactory(
      () => UserSignUpUseCase(authRepoSitory: serviceLocator<AuthRepoImpl>()));
  serviceLocator.registerFactory(
      () => UserLoginUsecase(authRepo: serviceLocator<AuthRepoImpl>()));
  serviceLocator.registerFactory(
      () => UserGetDataUsecase(authRepoSitory: serviceLocator<AuthRepoImpl>()));
  serviceLocator.registerLazySingleton(() => AuthBloc(
      appUserCubit: serviceLocator<AppUserCubit>(),
      userGetDataUsecase: serviceLocator<UserGetDataUsecase>(),
      userSignUpUseCase: serviceLocator<UserSignUpUseCase>(),
      userLoginUseCase: serviceLocator<UserLoginUsecase>()));
}

_initBlog() {
  serviceLocator.registerFactory(() => BlogRemoteDataSourceImpl(
      supabaseClient: serviceLocator<SupabaseClient>()));
  serviceLocator.registerFactory(() => BlogRepoImpl(
      localDataSouce: serviceLocator<BlogLocalDataSourceImpl>(),
      connectionChecker: serviceLocator<ConnectionCheckerImpl>(),
      dataSource: serviceLocator<BlogRemoteDataSourceImpl>()));
  serviceLocator.registerFactory(
      () => UploadBlogUsecase(blogRepository: serviceLocator<BlogRepoImpl>()));
  serviceLocator.registerFactory(
      () => GetAllBlogsUseCase(blogRepository: serviceLocator<BlogRepoImpl>()));
  serviceLocator.registerLazySingleton(
    () => BlogBloc(
        uploadBlogUsecase: serviceLocator<UploadBlogUsecase>(),
        getAllBlogsUseCase: serviceLocator<GetAllBlogsUseCase>()),
  );
}
