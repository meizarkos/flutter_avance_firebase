import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_avance_firebase/core/repositories/posts/posts_repositiory.dart';

import '../../models/post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {

  final PostsRepository postsRepository;

  PostsBloc({required this.postsRepository}) : super(PostsState()) {
    on<AddPost>(_onAddPost);
    on<FetchPosts>(_onFetchPosts);
    on<UpdatePost>(_onUpdatePost);
  }


  void _onUpdatePost(UpdatePost event, Emitter<PostsState> emit) async {
    emit(state.copyWith(updateStatus: PostsStatus.loading));
    try{
      await postsRepository.updatePost(event.post);
      final currentPosts = state.posts;
      final updatedPosts = currentPosts.map((post) {
        return post.id == event.post.id ? event.post : post;
      }).toList();
      emit(state.copyWith(posts: updatedPosts, updateStatus: PostsStatus.success));
      emit(state.copyWith(updateStatus: PostsStatus.initial));
    } catch (e) {
      emit(state.copyWith(
        updateStatus: PostsStatus.error,
        error: Exception('Failed to update post'),
      ));
      return;
    }
  }

  void _onAddPost(AddPost event, Emitter<PostsState> emit) async {
    emit(state.copyWith(addStatus: PostsStatus.loading));
    try{
      var postToAdd = await postsRepository.addPost(event.title, event.content);
      final currentPosts = state.posts;
      emit(state.copyWith(posts: [...currentPosts, postToAdd],addStatus: PostsStatus.success));
      emit(state.copyWith(addStatus: PostsStatus.initial));
    } catch (e) {
      emit(state.copyWith(
        addStatus: PostsStatus.error,
        error: Exception('Failed to add post'),
      ));
      return;
    }
  }

  void _onFetchPosts(FetchPosts event, Emitter<PostsState> emit) async{
    emit(state.copyWith(status: PostsStatus.loading));
    try{
      final posts = await postsRepository.getPosts();
      emit(state.copyWith(
        status: PostsStatus.success,
        posts: posts,
      ));
      return;
    }
    catch(e){
      print(e);
      emit(state.copyWith(
        status: PostsStatus.error,
        error: Exception('Failed to fetch posts'),
      ));
    }
  }
}
