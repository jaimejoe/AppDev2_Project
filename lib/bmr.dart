import 'dart:math';
import 'package:final_project_newest/dieting.dart';
import 'package:flutter/material.dart';
import 'firestoremanager.dart';


class BMR extends StatefulWidget {
  const BMR({super.key});

  @override
  State<BMR> createState() => _BMRState();
}

class _BMRState extends State<BMR> {
  //this whole section receives the arg username------------------------------
  String username = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      setState(() {
        username = args;
        print(username);
      });
    }
  }
//-------------------------------------------------------------------------
  TextEditingController _age = new TextEditingController();
  TextEditingController _height = new TextEditingController();
  TextEditingController _weight = new TextEditingController();
  double bmi = 0;
  int selectedOption = 1;
  String dietchoice = "Strenght";
  FirestoreManager firestoreManager = new FirestoreManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.grey],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'BMR CALCULATOR',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.blueGrey,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                //--------------------------------------------start of radio
                  SizedBox(
                    width:700,
                      child:
                Row(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 160,
                    child: ListTile(
                        title: const Text('Male'),
                        leading: Radio<int>(
                            value: 1,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                                dietchoice = "Male";
                              });
                            })),
                  ),
                  SizedBox(
                    height: 50,
                    width: 160,
                    child: ListTile(
                        title: const Text('Female'),
                        leading: Radio<int>(
                            value: 2,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                                dietchoice = "Female";
                              });
                            })),
                  ),
                ]
                )),
//-------------------------------------------end of radio
                  // Age field
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                    controller: _age,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Height(cm)',
                            border: OutlineInputBorder(),
                          ),
                          controller: _height,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Weight(kg)',
                            border: OutlineInputBorder(),
                          ),
                          controller: _weight,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_height.text.isNotEmpty &&
                            _weight.text.isNotEmpty) {
                          if(selectedOption==1){
                            bmi = ((13.397*(double.parse(_weight.text)))+(4.799*(double.parse(_height.text)))+(-5.677*double.parse(_age.text)))+88.362;
                          }else{
                            bmi = 447.593+(9.247*(double.parse(_weight.text))+3.098*(double.parse(_height.text))-4.330*double.parse(_age.text));
                          }

                          //under 18.5 which means you're considered underweight
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      "You're BMR is ${bmi.toStringAsFixed(0)}"),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(''),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          firestoreManager.updateUser(username, 'bmr',bmi.toStringAsFixed(0) );
                                          Navigator.pushNamed(
                                            context,
                                            '/home',
                                            arguments: username,
                                          );
                                        },
                                        child: Text("Close"))
                                  ],
                                );
                              });
                        } else {
                          const snackBar = SnackBar(
                              content: Text('You must fill out all fields'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text("Submit")),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}