import 'package:flutter/material.dart';
import 'package:flutter_avance_firebase/core/blocs/posts_bloc/posts_bloc.dart';
import 'package:flutter_avance_firebase/core/models/post.dart';
import 'package:flutter_avance_firebase/widget/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPostScreen extends StatefulWidget {
  static const String routeName = '/add_post';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
      listenWhen: (previous, current) {
        return previous.addStatus != current.addStatus;
      },
      listener: (context, state) {
        if (state.addStatus == PostsStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Post added successfully")),
          );
          Navigator.of(context).pop();
        } else if (state.addStatus == PostsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.error?.toString()}")),
          );
        }
      },
      builder: (context, state) {
        if(state.addStatus == PostsStatus.loading) {
          return LoadingWidget();
        }
        return _buildMainScreen(context);
      },
    );
  }

  Widget _buildMainScreen(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Add Post")),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
              maxLength: 25,
              controller: titleController,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(
                labelText: "Content",
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              maxLength: 200,
              controller: contentController,
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty ||
                    contentController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill in all fields"),
                    ),
                  );
                  return;
                }
                context.read<PostsBloc>().add(
                  AddPost(titleController.text, contentController.text),
                );
              },
              child: const Text("Submit Post"),
            ),
          ],
        ),
      ),
    );
  }
}
