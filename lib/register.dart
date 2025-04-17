import 'package:flutter/material.dart';
import 'firestoremanager.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int selectedOption = 1;
  String dietchoice = "Weight Gain";

  @override
  Widget build(BuildContext context) {
    TextEditingController _username = new TextEditingController();
    TextEditingController _password = new TextEditingController();
    TextEditingController _email = new TextEditingController();
    TextEditingController _firstname = new TextEditingController();
    return Scaffold(
        body: Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
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
            padding: EdgeInsets.only(top: 70, bottom: 30),
            child: Text(
              "Welcome new User!!!",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          Text("Please enter your information", style: TextStyle(fontSize: 20)),

          Row(
            //--------------------------------------------start of radio
            children: [
              SizedBox(
                height: 50,
                width: 200,
                child: ListTile(
                    title: const Text('Weight Gain'),
                    leading: Radio<int>(
                        value: 1,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                            dietchoice = "WeightGain";
                          });
                        })),
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ListTile(
                    title: const Text('Weight Loss'),
                    leading: Radio<int>(
                        value: 2,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                            dietchoice = "WeightLoss";
                          });
                        })),
              ),
            ],
          ),
          //-------------------------------------------end of radio

          SizedBox(
            height: 60,
            width: 280,
            child: TextField(
              decoration:
                  InputDecoration(hintText: 'Please enter your username'),
              controller: _username,
            ),
          ),

          TextField(
            decoration:
                InputDecoration(hintText: 'Please enter your firstname'),
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
              ElevatedButton(
                  onPressed: () async {
                    int success = 20;
                    FirestoreManager firestore = new FirestoreManager();
                    if (_username.text.isNotEmpty &&
                        _email.text.isNotEmpty &&
                        _password.text.isNotEmpty &&
                        _firstname.text.isNotEmpty) {
                      success = await firestore.createUser(
                          _username.text,
                          _email.text,
                          _password.text,
                          _firstname.text,
                          dietchoice);

                      if (success == 0) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                    "You have successfully signed up!"),
                                content: const SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text('We thank you for your patronage'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/login');
                                      },
                                      child: Text("Go to login page"))
                                ],
                              );
                            });
                      } else {
                        // in case username already exists
                        const snackBar = SnackBar(
                            content:
                                Text('Username already exists or is invalid'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } else {
                      //in case any of the fiels are empty
                      const snackBar = SnackBar(
                          content: Text('You must fill out every field'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text("Register")),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text("Already have an account?")),
            ],
          )
        ],
      ),
    ));
  }
}
