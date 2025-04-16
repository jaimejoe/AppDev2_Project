import 'package:flutter/material.dart';
import 'firestoremanager.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _username = new TextEditingController();
    TextEditingController _password = new TextEditingController();

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            TextField(
              decoration: InputDecoration(hintText: "Enter your username"),
              controller: _username,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Enter your password"),
              controller: _password,
            ),

            ElevatedButton(onPressed: (){

            }, child: Text("Log In")),

            TextButton(onPressed: (){
              Navigator.pushNamed(context, '/register');
            }, child: Text("Dont have an account? Go to register page")),
            


          ],
        ),
      ),
    );
  }
}

