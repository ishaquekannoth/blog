import 'package:blog/core/error/exceptions.dart';
import 'package:blog/feature/auth/data/datasource/remote_data_source_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteDataSourceImpl implements IAuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  RemoteDataSourceImpl({required this.supabaseClient});
  @override
  Future<String> logInWithEmailAndPassword(
      {required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final AuthResponse authResponse = await supabaseClient.auth.signUp(
        email: email,
        password: password,
      );
      if (authResponse.user != null) {
        return authResponse.user!.id;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
