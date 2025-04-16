import 'package:flutter/material.dart';
import 'firestoremanager.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _username = new TextEditingController();
    TextEditingController _password = new TextEditingController();
    TextEditingController _email = new TextEditingController();
    TextEditingController _firstname = new TextEditingController();
    return Scaffold(

    body: Container(
    width: double.infinity,
    /*decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [Colors.blue,Colors.black ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    ),
    ),*/
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 70,bottom: 30),
            child: Text("Welcome new User!!!",style: TextStyle(color: Colors.white,fontSize: 30),),
          ),
          Text("Please enter your information",style: TextStyle(fontSize: 20)),
          SizedBox(
            height: 60,
            width: 280,
            child: TextField(
              decoration: InputDecoration(hintText: 'Please enter your username'),
              controller: _username,
            ),
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Please enter your firstname'),
            controller: _firstname,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Please enter your email'),
            controller: _email,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Please enter your password'),
            controller: _password,
          ),
          Row(
            children: [
              ElevatedButton(onPressed: (){
                FirestoreManager firestore = new FirestoreManager();
                firestore.createUser(_username.text,_email.text,_password.text,_firstname.text);
                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(
                    title: const Text("You have successfully signed up!"),
                    content: const SingleChildScrollView(
                      child: ListBody(
                  children: <Widget>[
                  Text('We thank you for your patronage'),
                  ],
                      ),
                    ),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pushNamed(context, '/login');
                      }, child: Text("Go to login page"))
                    ],
                  );
                }
                );

              }, child: Text("Register")),


              TextButton(onPressed: (){
                Navigator.pushNamed(context, '/login');
              }, child: Text("Already have an account?")
              ),


            ],
          )


        ],
      ),
    ));
  }
}
