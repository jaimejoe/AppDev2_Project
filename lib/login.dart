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

            ElevatedButton(onPressed: ()async{
              FirestoreManager firestore = new FirestoreManager();
              var user = await firestore.retrieveUser(_username.text);
              if (user == null){
                const snackBar = SnackBar(content: Text('Incorrect username or password'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }else if(user['username']==_username.text && user['password']== _password.text){
                Navigator.pushNamed(
                  context,
                  '/home',
                  arguments: _username.text,
                  //if we need more args we could use { 'username':_username.text, ...}
                );
              }else{
                const snackBar = SnackBar(content: Text('Incorrect username or password'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
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


