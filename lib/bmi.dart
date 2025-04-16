import 'package:flutter/material.dart';


class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  var _age;
  var _gender;
  var _height;
  var _weight;
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
            decoration: InputDecoration(hintText: 'Age:'),
            controller: _gender,
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

          }, child: Text("Submit"))

        ],
      ),
    );
  }
}
