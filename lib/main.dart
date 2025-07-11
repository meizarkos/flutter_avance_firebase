import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avance_firebase/auth/auth.dart';
import 'package:flutter_avance_firebase/core/blocs/posts_bloc/posts_bloc.dart';
import 'package:flutter_avance_firebase/core/repositories/posts/firebase_data_source.dart';
import 'package:flutter_avance_firebase/core/repositories/posts/posts_repositiory.dart';
import 'package:flutter_avance_firebase/post_screen/add_post_screen.dart';
import 'package:flutter_avance_firebase/post_screen/modify_post_screen.dart';
import 'package:flutter_avance_firebase/post_screen/posts_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/models/post.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  if (kDebugMode) {
    try {
      final localhost = switch (defaultTargetPlatform) {
        TargetPlatform.android => '10.0.2.2', _ => 'localhost',
      };
      FirebaseFirestore.instance.useFirestoreEmulator(localhost, 8080);
      await FirebaseAuth.instance.useAuthEmulator(localhost, 9099);
    }
    catch (e) {
      print("Error initializing Firebase: $e");
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc(postsRepository: PostsRepository(firebaseDataSource: FirebaseDataSource())),
      child: MaterialApp(
        routes: {
          '/': (context) => const AuthScreen(),
          PostsScreen.routeName: (context) => const PostsScreen(),
          AddPostScreen.routeName: (context) => const AddPostScreen(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case ModifyPostScreen.routeName:
              final args = settings.arguments;
              if(args is Post){
                return MaterialPageRoute(
                  builder: (context) => ModifyPostScreen(post: args),
                );
              }
          }
          return null;
        },
      ),
    );
  }
}
