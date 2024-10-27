import 'package:blog/core/secrets/app_secrets.dart';
import 'package:blog/core/theme/theme.dart';
import 'package:blog/feature/auth/data/datasource/remote_data_source_impl.dart';
import 'package:blog/feature/auth/data/repositories/auth_repo_impl.dart';
import 'package:blog/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:blog/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/feature/auth/presentation/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Supabase supBase =
      await Supabase.initialize(anonKey: anonKey, url: supBaseUrl);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (_) => AuthBloc(
              useCase: UserSignUpUseCase(
                  authRepoSitory: AuthRepoImpl(
                      authRemoteDataSource: RemoteDataSourceImpl(
                          supabaseClient: supBase.client)))))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blog',
        theme: AppTheme.darkThemeMode,
        home: const LoginPage());
  }
}
