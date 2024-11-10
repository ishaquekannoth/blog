import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/use_case.dart';
import 'package:blog/feature/blog/domain/repositories/blog_repo.dart';
import 'package:fpdart/fpdart.dart';

class ClearAllDatabaseUseCase implements UseCase<String, NoParam> {
  IBlogRepository blogRepository;
  ClearAllDatabaseUseCase({
    required this.blogRepository,
  });
  @override
  Future<Either<Failure, String>> call({required NoParam parameters}) async{
    return await blogRepository.clearAllData();
  }
}
