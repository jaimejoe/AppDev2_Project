import 'package:flutter/material.dart';
import 'home.dart';
import 'register.dart';
import 'splashScreen.dart';

void main() {
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
        '/login':(context) => Register(),
        '/home':(context) => Home(),
        '/profile':(context) => Register(),//to be made
      },
    );
  }
}

