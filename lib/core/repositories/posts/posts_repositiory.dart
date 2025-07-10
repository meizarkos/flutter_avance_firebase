import 'package:flutter_avance_firebase/core/models/post.dart';
import 'package:flutter_avance_firebase/core/repositories/posts/posts_data_source.dart';

class PostsRepository {
  final PostsDataSource firebaseDataSource;

  const PostsRepository({
    required this.firebaseDataSource
  });

  Future<List<Post>> getPosts() async {
    return await firebaseDataSource.getPosts();
  }

  Future<Post> addPost(String title,String content) async {
    return await firebaseDataSource.addPost(title,content);
  }

  Future<Post> updatePost(Post post) async {
    return await firebaseDataSource.updatePost(post);
  }
}