import 'package:blog/core/usecase/use_case.dart';
import 'package:blog/feature/blog/domain/entities/blog.dart';
import 'package:blog/feature/blog/domain/use_cases/get_all_blogs_use_case.dart';
import 'package:blog/feature/blog/domain/use_cases/upload_blog_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase _uploadBlogUsecase;
  final GetAllBlogsUseCase _getAllBlogsUseCase;
  BlogBloc(
      {required UploadBlogUsecase uploadBlogUsecase,
      required GetAllBlogsUseCase getAllBlogsUseCase})
      : _uploadBlogUsecase = uploadBlogUsecase,
        _getAllBlogsUseCase = getAllBlogsUseCase,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => BlogLoading());
    on<BlogUpload>(_onBlogUpload);
    on<BlogsFetchAll>(_onGetAllBlogs);
  }
  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final result = await _uploadBlogUsecase(parameters: event.uploadBlogParam);

    result.fold((failure) => emit(BlogOperationFailure(error: failure.message)),
        (success) => emit(BlogUploadSuccess()));
  }

  void _onGetAllBlogs(BlogsFetchAll event, Emitter<BlogState> emit) async {
    final result = await _getAllBlogsUseCase(parameters: NoParam());

    result.fold((failure) => emit(BlogOperationFailure(error: failure.message)),
        (blogs) => emit(BlogFetchSuccess(blogs: blogs)));
  }
}
