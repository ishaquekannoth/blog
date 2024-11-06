import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/use_case.dart';
import 'package:blog/core/entities/user.dart';
import 'package:blog/feature/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserGetDataUsecase implements UseCase<User, NoParam> {
  IAuthRepoSitory authRepoSitory;
  UserGetDataUsecase({
    required this.authRepoSitory,
  });
  @override
  Future<Either<Failure, User>> call(NoParam noParam) async {
    return await authRepoSitory.getUserData();
  }
}
