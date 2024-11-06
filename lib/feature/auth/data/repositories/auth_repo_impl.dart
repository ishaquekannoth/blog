import 'package:blog/core/error/exceptions.dart';
import 'package:blog/core/error/failures.dart';
import 'package:blog/feature/auth/data/datasource/remote_data_source_repo.dart';
import 'package:blog/core/entities/user.dart';
import 'package:blog/feature/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepoImpl implements IAuthRepoSitory {
  final IAuthRemoteDataSource authRemoteDataSource;
  AuthRepoImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, User>> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(() => authRemoteDataSource.logInWithEmailAndPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    return _getUser(() async =>
        await authRemoteDataSource.signUpWithEmailAndPassword(
            email: email, password: password, name: name));
  }

  @override
  Future<Either<Failure, User>> getUserData() async {
    try {
      final User? user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) return left(Failure('User is not logged in'));
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
  try {
    final User user = await fn();
    return right(user);
  } on ServerException catch (e) {
    return left(Failure(e.message));
  }
}
