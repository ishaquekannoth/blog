import 'package:blog/core/error/failures.dart';
import 'package:blog/feature/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IAuthRepoSitory {
  Future<Either<Failure, User>> logInWithEmailAndPassword(
      {required String email, required String password});
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String email, required String password, required String name});
}
