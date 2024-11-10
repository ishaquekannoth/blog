import 'package:blog/feature/blog/data/model/blog_model.dart';
import 'package:blog/feature/blog/domain/entities/blog.dart';

abstract interface class IBlogLocalDataSouce {
  Future<void> saveBlogToDisk({required List<BlogModel> blogs});
  Future<List<Blog>> loadBlogFromDisk();
   Future<String> clearAllData();
}
