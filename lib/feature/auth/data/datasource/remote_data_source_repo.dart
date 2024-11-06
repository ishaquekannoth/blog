import 'package:blog/core/entities/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Session;

abstract interface class IAuthRemoteDataSource {
  Session? get currentSession;
  Future<User> logInWithEmailAndPassword(
      {required String email, required String password});
  Future<User> signUpWithEmailAndPassword(
      {required String email, required String password, required String name});
  Future<User?> getCurrentUserData();
}
