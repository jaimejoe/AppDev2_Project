import 'package:flutter/material.dart';
import 'firestoremanager.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int selectedOption = 1;
  String dietchoice = "Strenght";

  @override
  Widget build(BuildContext context) {
    TextEditingController _username = new TextEditingController();
    TextEditingController _password = new TextEditingController();
    TextEditingController _email = new TextEditingController();
    TextEditingController _firstname = new TextEditingController();
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.greenAccent, Colors.grey], begin: Alignment.bottomLeft, end: Alignment.topRight )
          ),
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
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
          Text("Let's Get You Started!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700 )),
          Row(
            //--------------------------------------------start of radio
            mainAxisAlignment: MainAxisAlignment.center,
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
                    title: const Text('Fat loss'),
                    leading: Radio<int>(
                        value: 2,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                            dietchoice = "FatLoss";
                          });
                        })),
              ),
//-------------------------------------------end of radio
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Username', border: OutlineInputBorder(), ),
                  controller: _username,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Firstname', border: OutlineInputBorder()),
                  controller: _firstname,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Email', border: OutlineInputBorder()),
                  controller: _email,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Password', border: OutlineInputBorder()),
                  controller: _password,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(
                    -634393319)
                ),
                  onPressed: () async {
                    int success = 20;
                    FirestoreManager firestore = new FirestoreManager();
                    if (_username.text.isNotEmpty &&
                        _email.text.isNotEmpty &&
                        _password.text.isNotEmpty &&
                        _firstname.text.isNotEmpty) {
                      success = await firestore.createUser(_username.text,
                          _email.text, _password.text, _firstname.text, dietchoice);

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
                  child: Text("Register",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
              SizedBox(
                width: 50,
              ),
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
