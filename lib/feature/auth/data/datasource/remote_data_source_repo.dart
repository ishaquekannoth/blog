import 'package:blog/feature/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Session;

abstract interface class IAuthRemoteDataSource {
  Session? get currentSession;
  Future<UserModel> logInWithEmailAndPassword(
      {required String email, required String password});
  Future<UserModel> signUpWithEmailAndPassword(
      {required String email, required String password, required String name});
  Future<UserModel?> getCurrentUserData();
}
