import 'package:blog/feature/blog/data/data_source/blog_local_data_source.dart';
import 'package:blog/feature/blog/data/data_source/data_base_helper.dart';
import 'package:blog/feature/blog/data/model/blog_model.dart';
import 'package:sqflite/sqflite.dart';

class BlogLocalDataSourceImpl implements IBlogLocalDataSouce {
  final DatabaseHelper databaseHelper;
  BlogLocalDataSourceImpl({required this.databaseHelper});
  @override
  Future<List<BlogModel>> loadBlogFromDisk() async {
    Database database = await databaseHelper.database;
    final blogList = await database.query('blogs');
    if (blogList.isEmpty) return [];
    return List<BlogModel>.from(
            (blogList.map((element) => BlogModel.fromJson(element, true))))
        .toList();
  }

  @override
  Future<void> saveBlogToDisk({required List<BlogModel> blogs}) async {
    Database database = await databaseHelper.database;
    for (var blog in blogs) {
      final blogJson = blog.toJson();
      await database.insert('blogs', blogJson,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<String> clearAllData() async {
    if (await _isDatabaseEmpty()) "Data base is Empty !!";
    final db = await databaseHelper.database;
    await db.delete('blogs');
    return "Removed All local Cache's !";
  }

  Future<bool> _isDatabaseEmpty() async {
    final db = await databaseHelper.database;
    final count =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM blogs'));
    return count == 0;
  }
}
