import 'dart:io';

import 'package:blog/feature/blog/data/model/blog_model.dart';

abstract interface class IBlogDataSource {
  Future<BlogModel> uploadBlog({required BlogModel blog});
  Future<String> uploadBlogImage(
      {required BlogModel blog, required File blogImage});
  Future<List<BlogModel>> getAllBlogs();
}
