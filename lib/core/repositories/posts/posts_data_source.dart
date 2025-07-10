import '../../models/post.dart';

abstract class PostsDataSource {
  Future<List<Post>> getPosts();
  Future<Post> addPost(String title, String content);
  Future<Post> updatePost(Post post);
}