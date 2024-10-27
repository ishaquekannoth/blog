abstract interface class IAuthRemoteDataSource {
  Future<String> logInWithEmailAndPassword(
      {required String email, required String password});
  Future<String> signUpWithEmailAndPassword(
      {required String email, required String password, required String name});
}
