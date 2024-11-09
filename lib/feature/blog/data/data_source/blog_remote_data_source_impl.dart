import 'dart:io';

import 'package:blog/core/error/exceptions.dart';
import 'package:blog/feature/blog/data/data_source/blog_remote_data_source.dart';
import 'package:blog/feature/blog/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlogRemoteDataSourceImpl implements IBlogDataSource {
  SupabaseClient supabaseClient;
  BlogRemoteDataSourceImpl({
    required this.supabaseClient,
  });
  @override
  Future<BlogModel> uploadBlog({required BlogModel blog}) async {
    try {
      final blogs =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogs.first);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required BlogModel blog, required File blogImage}) async {
    try {
      await supabaseClient.storage
          .from('blog_images')
          .upload(blog.id, blogImage);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await supabaseClient.from('blogs').select(
            '* ,profiles(name)',
          );
      return blogs
          .map((element) => BlogModel.fromJson(element)
              .copyWith(posterName: element['profiles']['name']))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
