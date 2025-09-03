import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_project/landing_page_maneger.dart';
import 'package:test_project/pages/home_page.dart';
import 'package:test_project/pages/login_page.dart';
import 'package:test_project/pages/profile_page.dart';
import 'package:test_project/pages/signup_page.dart';
import 'package:test_project/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBoLTA2uYPQv1d6z0qS_0mcNiLUniHCfVQ',
          appId: '1:377895053360:android:9b60d7485b02c6767725f5',
          messagingSenderId: '377895053360',
          projectId: 'test-project-1d4d6',
          storageBucket: 'test-project-1d4d6.firebasestorage.app',
          )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'my app',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
    );
  }
}


