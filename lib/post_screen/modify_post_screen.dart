import 'package:flutter/material.dart';
import 'package:flutter_avance_firebase/widget/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/blocs/posts_bloc/posts_bloc.dart';
import '../core/models/post.dart';

class ModifyPostScreen extends StatefulWidget {
  static const String routeName = '/modify_post';

  final Post post;

  const ModifyPostScreen({super.key, required this.post});

  @override
  State<ModifyPostScreen> createState() => _ModifyPostScreenState();
}

class _ModifyPostScreenState extends State<ModifyPostScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.post.title ?? '';
    contentController.text = widget.post.content ?? '';
  }

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
        return previous.updateStatus != current.updateStatus;
      },
      listener: (context, state) {
        if (state.updateStatus == PostsStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Post added successfully")),
          );
          Navigator.of(context).pop();
        } else if (state.updateStatus == PostsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.error?.toString()}")),
          );
        }
      },
      builder: (context, state) {
        if(state.updateStatus == PostsStatus.loading) {
          return LoadingWidget();
        }
        return _buildMainScreen(context);
      },
    );
  }

  Widget _buildMainScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Modify Post")),
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
                if (titleController.text.isEmpty || contentController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill in all fields"),
                    ),
                  );
                  return;
                } else if (titleController.text == widget.post.title &&
                    contentController.text == widget.post.content) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("No changes made to the post"),
                    ),
                  );
                  return;
                }

                final updatedPost = Post(
                  id: widget.post.id,
                  title: titleController.text,
                  content: contentController.text,
                  timestamp: DateTime.now().millisecondsSinceEpoch,
                );

                context.read<PostsBloc>().add(UpdatePost(updatedPost));
              },
              child: const Text("Update Post"),
            ),
          ],
        ),
      ),
    );
  }
}
