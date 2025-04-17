import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      drawer: Drawer(
        child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Welcome $username'),
          ),

          ListTile(//sends you to profile
            title: Row(
              children: [Text("Profile"),Icon(Icons.person)],
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/profile',
                arguments: username,
              );
            },
          ),

          ListTile(//sends you to profile
            title: Row(
              children: [Text("Calculate BMI"),Icon(Icons.calculate)],
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/bmi',
                arguments: username,
              );
            },
          ),


        ],
      ),
      ),

      body: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


          ],
        ),
      ),
    );
  }
}
