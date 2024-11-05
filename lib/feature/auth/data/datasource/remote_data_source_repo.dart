import 'package:blog/feature/auth/domain/entities/user.dart';

abstract interface class IAuthRemoteDataSource {
  Future<User> logInWithEmailAndPassword(
      {required String email, required String password});
  Future<User> signUpWithEmailAndPassword(
      {required String email, required String password, required String name});
}
