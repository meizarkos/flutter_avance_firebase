import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avance_firebase/post_screen/posts_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
        ),
        ElevatedButton(onPressed: ()=>_signIn(context), child: Text('Sign In')),
      ],
    );
  }

  void _signIn(BuildContext context) async{
    final email = _emailController.text;
    final password = _passwordController.text;

    print('Email: $email & Password: $password');
    try{
      final userCredentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushReplacementNamed(PostsScreen.routeName);
      print(userCredentials.user?.uid);
    }
    catch(e){
      print('Error: $e');
    }
  }
}
