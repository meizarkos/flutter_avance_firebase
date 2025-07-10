part of 'posts_bloc.dart';

enum PostsStatus {
  initial,
  loading,
  success,
  error,
}

class PostsState{
  final PostsStatus status;
  final PostsStatus addStatus;
  final PostsStatus updateStatus;
  final List<Post> posts;
  final Exception? error;

  PostsState({
    this.status = PostsStatus.initial,
    this.addStatus = PostsStatus.initial,
    this.updateStatus = PostsStatus.initial,
    this.posts = const [],
    this.error,
  });

  PostsState copyWith({
    PostsStatus? status,
    PostsStatus? addStatus,
    PostsStatus? updateStatus,
    List<Post>? posts,
    Exception? error,
  }) {
    return PostsState(
      status: status ?? this.status,
      addStatus: addStatus ?? this.addStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }
}