import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avance_firebase/auth/login_form.dart';
import 'package:flutter_avance_firebase/post_screen/posts_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if(FirebaseAuth.instance.currentUser != null){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(PostsScreen.routeName);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot) {
            final user = snapshot.data;
            if(user == null){
              return LoginForm();
            }
            return SizedBox();
          }
      )
    );
  }
}
