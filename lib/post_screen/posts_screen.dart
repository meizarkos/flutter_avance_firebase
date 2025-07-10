import 'package:flutter/material.dart';
import 'package:flutter_avance_firebase/post_screen/modify_post_screen.dart';
import 'package:flutter_avance_firebase/utils/posted_ago.dart';
import 'package:flutter_avance_firebase/widget/error_widget.dart';
import 'package:flutter_avance_firebase/widget/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_avance_firebase/core/blocs/posts_bloc/posts_bloc.dart';

import '../core/models/post.dart';

class PostsScreen extends StatefulWidget {
  static const String routeName = '/posts';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {

  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(FetchPosts());
  }

  @override
  Widget build(BuildContext context) {
    final posts = context.watch<PostsBloc>().state.posts;
    final status = context.watch<PostsBloc>().state.status;
    return Scaffold(
      appBar: AppBar(
        title: Text("Post list"),
      ),
      body: _buildList(context, posts,status),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_post');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Post> posts, PostsStatus status) {
    if (status == PostsStatus.loading) {
      return LoadingWidget();
    }
    else if(status == PostsStatus.error) {
      return CustomError();
    }
    else if (posts.isEmpty) {
      return _buildEmptyPosts(context);
    }
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return _buildPostItem(context, post);
      },
    );
  }

  Widget _buildPostItem(BuildContext context, Post post) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ModifyPostScreen.routeName, arguments: post);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  post.title ?? 'No title',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  "Posted ${timeAgo(post.timestamp ?? DateTime.now().millisecondsSinceEpoch)}",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              post.content ?? 'No content',
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyPosts(BuildContext context){
    return Center(
      child: Text(
        'List is empty',
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
