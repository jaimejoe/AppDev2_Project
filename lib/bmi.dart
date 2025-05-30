import 'dart:math';
import 'package:flutter/material.dart';
import 'firestoremanager.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
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
  FirestoreManager firestoreManager = new FirestoreManager();
  double bmi = 0;
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
              'BMI CALCULATOR',
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
                          bmi = double.parse(_weight.text) /
                              pow(double.parse(_height.text) / 100, 2);
                          print(bmi);
                          String message = "";
                          if (bmi > 40) {
                            message =
                            "over 40 you are considered class 3 obese";
                          }
                          if (bmi < 40) {
                            message =
                            "between 35 and 39.9 then you are considered a class 2 obese";
                          }
                          if (bmi < 35) {
                            message =
                            "between 30 and 34.9 then you are considered a class 1 obese";
                          }
                          if (bmi < 30) {
                            message =
                            "between 25 and 29.5 then you are considered overweight";
                          }
                          if (bmi < 25) {
                            message =
                            "between 18.5 and 24.9 then you have normal weight";
                          }
                          if (bmi < 18.5) {
                            message =
                            "less than 18.5 you are considered underweight";
                          }
                          firestoreManager.addBMI(username, bmi);
                          //under 18.5 which means you're considered underweight
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      "You're BMI is ${bmi.toStringAsFixed(1)}"),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text('Since your bmi is $message'),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
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
            // TextButton(
            //     onPressed: () {
            //       Navigator.pushNamed(
            //         context,
            //         '/home',
            //         arguments: username,
            //       );
            //     },
            //     child: Text("Go back Home"))
          ],
        ),
      ),
    );
  }
}