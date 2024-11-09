import 'package:fpdart/src/either.dart';

import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/use_case.dart';
import 'package:blog/feature/blog/domain/entities/blog.dart';
import 'package:blog/feature/blog/domain/repositories/blog_repo.dart';

class GetAllBlogsUseCase implements UseCase<List<Blog>, NoParam> {
  IBlogRepository blogRepository;
  GetAllBlogsUseCase({
    required this.blogRepository,
  });
  @override
  Future<Either<Failure, List<Blog>>> call(
      {required NoParam parameters}) async {
    return await blogRepository.getAllBlogs();
  }
}
