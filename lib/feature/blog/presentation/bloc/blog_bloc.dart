import 'package:blog/core/usecase/use_case.dart';
import 'package:blog/feature/blog/domain/entities/blog.dart';
import 'package:blog/feature/blog/domain/use_cases/clear_database_use_case.dart';
import 'package:blog/feature/blog/domain/use_cases/get_all_blogs_use_case.dart';
import 'package:blog/feature/blog/domain/use_cases/upload_blog_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase _uploadBlogUsecase;
  final GetAllBlogsUseCase _getAllBlogsUseCase;
  final ClearAllDatabaseUseCase _clearAllDatabaseUseCase;
  BlogBloc(
      {required UploadBlogUsecase uploadBlogUsecase,
      required ClearAllDatabaseUseCase clearAllDatabaseUseCase,
      required GetAllBlogsUseCase getAllBlogsUseCase})
      : _uploadBlogUsecase = uploadBlogUsecase,
        _getAllBlogsUseCase = getAllBlogsUseCase,
        _clearAllDatabaseUseCase = clearAllDatabaseUseCase,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => BlogLoading());
    on<BlogUpload>(_onBlogUpload);
    on<BlogsFetchAll>(_onGetAllBlogs);
    on<BlogClearAll>(_onClearAll);
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

  void _onClearAll(BlogClearAll event, Emitter<BlogState> emit) async {
    final result = await _clearAllDatabaseUseCase(parameters: NoParam());
    final blogState = state;
    emit(BlogOperationSuccess(message: "Cleared all the local Blogs"));
    result.fold((failure) => emit(BlogOperationFailure(error: failure.message)),
        (success) => emit(blogState));
  }
}
