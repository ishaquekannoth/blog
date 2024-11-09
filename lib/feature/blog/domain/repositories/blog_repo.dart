import 'dart:io';

import 'package:blog/core/error/failures.dart';
import 'package:blog/feature/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IBlogRepository {
  Future<Either<Failure, Blog>> uploadBlog(
      {required String title,
      required String content,
      required String posterId,
      required List<String> topics,
      required File image});
  Future<Either<Failure, List<Blog>>> getAllBlogs();
}
