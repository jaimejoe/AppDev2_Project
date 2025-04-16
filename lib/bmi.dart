import 'dart:math';

import 'package:flutter/material.dart';


class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  TextEditingController _age = new TextEditingController();
  TextEditingController _height = new TextEditingController();
  TextEditingController _weight = new TextEditingController();
  double bmi = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Age:'),
            controller: _age,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Enter your height in cm:'),
            controller: _height,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Enter your weight in kg:'),
            controller: _weight,
          ),
          ElevatedButton(onPressed: (){
            bmi = double.parse(_weight.text)*pow(double.parse(_height.text)/100,2);


          }, child: Text("Submit"))

        ],
      ),
    );
  }
}
