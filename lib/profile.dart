import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "BMI",
                        style: TextStyle(fontWeight: FontWeight.bold),

                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
