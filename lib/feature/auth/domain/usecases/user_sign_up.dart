import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/use_case.dart';
import 'package:blog/feature/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';


class UserSignUpUseCase implements UseCase<String, UserSignUpParams> {
  final IAuthRepoSitory authRepoSitory;
  UserSignUpUseCase({required this.authRepoSitory});
  @override
  Future<Either<Failure, String>> call(params) async {
    return await authRepoSitory.signUpWithEmailAndPassword(
        email: params.email, password: params.password, name: params.name);
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams(
      {required this.email, required this.password, required this.name});
}
