import 'package:blog/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IAuthRepoSitory {
  Future<Either<Failure, String>> logInWithEmailAndPassword(
      {required String email, required String password});
  Future<Either<Failure, String>> signUpWithEmailAndPassword(
      {required String email, required String password, required String name});
}
