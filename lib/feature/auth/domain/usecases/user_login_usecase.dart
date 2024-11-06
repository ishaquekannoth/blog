import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/use_case.dart';
import 'package:blog/core/entities/user.dart';
import 'package:blog/feature/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserLoginUsecase implements UseCase<User, UserLoginParams> {
  IAuthRepoSitory authRepo;
  UserLoginUsecase({
    required this.authRepo,
  });
  @override
  Future<Either<Failure, User>> call(UserLoginParams param) async {
    return await authRepo.logInWithEmailAndPassword(
        email: param.email, password: param.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
