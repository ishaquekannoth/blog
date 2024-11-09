part of 'blog_bloc.dart';


sealed class BlogEvent {}
final class BlogUpload extends BlogEvent {
  final UploadBlogParam uploadBlogParam;
  BlogUpload({required this.uploadBlogParam});

}
final class BlogsFetchAll extends BlogEvent{}