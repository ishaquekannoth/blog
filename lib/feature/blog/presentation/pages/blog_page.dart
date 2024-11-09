import 'package:blog/core/common/loader.dart';
import 'package:blog/core/utils/show_snackbar.dart';
import 'package:blog/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/feature/blog/presentation/pages/add_new_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(BlogsFetchAll());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog App"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, AddNewBlogPage.route());
              },
              icon: const Icon(CupertinoIcons.add_circled_solid))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogOperationFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogFetchSuccess) {
            return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return Text(state.blogs[index].title);
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
