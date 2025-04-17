import 'package:final_project_newest/firestoremanager.dart';
import 'package:flutter/material.dart';



class Dieting extends StatefulWidget {
  const Dieting({super.key});

  @override
  State<Dieting> createState() => _DietingState();
}

class _DietingState extends State<Dieting> {
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

    FirestoreManager firestore = new FirestoreManager();
    String type = firestore.retrieveUser(username)['type'];

    return Scaffold(
      appBar: AppBar(title: Text("Dieting"),),
      body: Column(

      ),
    );
  }
}
