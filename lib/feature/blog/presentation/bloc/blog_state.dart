part of 'blog_bloc.dart';

sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogUploadSuccess extends BlogState {
  BlogUploadSuccess();
}
final class BlogOperationFailure extends BlogState {
  final String error;
  BlogOperationFailure({required this.error});
}
final class BlogFetchSuccess extends BlogState {
  final List<Blog> blogs;
  BlogFetchSuccess({required this.blogs});
} 



