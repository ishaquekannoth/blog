import 'dart:io';

import 'package:blog/core/error/exceptions.dart';
import 'package:blog/core/error/failures.dart';
import 'package:blog/core/network/connection_checker.dart';
import 'package:blog/feature/blog/data/data_source/blog_local_data_source.dart';
import 'package:blog/feature/blog/data/data_source/blog_remote_data_source.dart';
import 'package:blog/feature/blog/data/model/blog_model.dart';
import 'package:blog/feature/blog/domain/entities/blog.dart';
import 'package:blog/feature/blog/domain/repositories/blog_repo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepoImpl implements IBlogRepository {
  IBlogDataSource dataSource;
  IBlogLocalDataSouce localDataSouce;
  ConnectionChecker connectionChecker;
  BlogRepoImpl(
      {required this.dataSource,
      required this.localDataSouce,
      required this.connectionChecker});
  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required String title,
      required String content,
      required String posterId,
      required List<String> topics,
      required File image}) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure('No internet Connection'));
      }
      BlogModel blogModel = BlogModel(
          id: const Uuid().v1(),
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: '',
          topics: topics,
          updatedAt: DateTime.now());
      final imageUrl =
          await dataSource.uploadBlogImage(blog: blogModel, blogImage: image);
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      return right(await dataSource.uploadBlog(blog: blogModel));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await connectionChecker.isConnected) {
        return right(await localDataSouce.loadBlogFromDisk());
      }
      final result = await dataSource.getAllBlogs();
      await localDataSouce.saveBlogToDisk(blogs: result);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> clearAllData() async {
    return right(await localDataSouce.clearAllData());
  }
}
