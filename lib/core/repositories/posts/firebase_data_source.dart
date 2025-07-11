import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_avance_firebase/core/repositories/posts/posts_data_source.dart';
import 'package:intl/intl.dart';

import '../../models/post.dart';

class FirebaseDataSource extends PostsDataSource {
  final CollectionReference postsCollection = FirebaseFirestore.instance.collection('posts');

  @override
  Future<Post> addPost(String title,String content) async {

    final docRef = await postsCollection.add({
      'title': title,
      'content': content,
    });

    return Post(
      id: docRef.id,
      title: title,
      content: content,
    );
  }

  @override
  Future<List<Post>> getPosts() async {
    final querySnapshot = await postsCollection.get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Post(
        id: doc.id,
        title: data['title'],
        content: data['content'],
        date: data['date'],
      );
    }).toList();
  }

  @override
  Future<Post> updatePost(Post post) async {
    final docRef = postsCollection.doc(post.id);

    await docRef.update({
      'title': post.title,
      'content': post.content,
    });

    return post;
  }
}
