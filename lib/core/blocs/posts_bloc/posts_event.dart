part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {
  const PostsEvent();
}

final class FetchPosts extends PostsEvent {
  const FetchPosts();
}

final class AddPost extends PostsEvent {
  final String title;
  final String content;

  const AddPost(this.title,this.content);
}

final class UpdatePost extends PostsEvent {
  final Post post;

  const UpdatePost(this.post);
}
