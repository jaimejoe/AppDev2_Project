import 'package:final_project_newest/firestoremanager.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'register.dart';
import 'splashScreen.dart';
import 'bmi.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'profile.dart';
import 'dieting.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCGW4NEnAgPmSHvp1FR7Md_DJ6R2yT-nCM",
          appId: "182440037540",
          messagingSenderId: "182440037540",
          projectId: "project-87428")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => Splashscreen(),
        '/register':(context) => Register(),
        '/login':(context) => Login(),
        '/home':(context) => Home(),
        '/profile':(context) => Profile(),//to be made
        '/bmi':(context) => BMI(),
        '/dieting':(context) => Dieting(),
      },
    );
  }
}

