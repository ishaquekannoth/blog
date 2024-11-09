import 'dart:io';

import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/use_case.dart';
import 'package:blog/feature/blog/domain/entities/blog.dart';
import 'package:blog/feature/blog/domain/repositories/blog_repo.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUsecase implements UseCase<Blog, UploadBlogParam> {
  IBlogRepository blogRepository;
  UploadBlogUsecase({
    required this.blogRepository,
  });
  @override
  Future<Either<Failure, Blog>> call(param) async {
    return await blogRepository.uploadBlog(
        title: param.title,
        content: param.content,
        posterId: param.posterId,
        topics: param.topics,
        image: param.image);
  }
}

class UploadBlogParam {
  final String posterId;
  final String content;
  final String title;
  final File image;
  final List<String> topics;
  UploadBlogParam(
      {required this.posterId,
      required this.content,
      required this.title,
      required this.image,
      required this.topics});
}
