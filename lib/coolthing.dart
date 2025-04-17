import 'package:final_project_newest/dieting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'firestoremanager.dart';

class noice extends StatefulWidget {
  const noice({super.key});

  @override
  State<noice> createState() => _noiceState();
}

class _noiceState extends State<noice> {
  FirestoreManager firestoreManager = new FirestoreManager();



  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _userStream =
    firestoreManager.firestore.collection('recipes').where('category',isEqualTo:'WeightLoss').snapshots();
    return StreamBuilder(
        stream: _userStream,
        builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot)
    {
      // this is to manipulate live data
      if (snapshot.hasError) {
        return Text("Something went wrong");
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading...");
      }
      return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
            Map<String, dynamic> data =
            document.data()! as Map<String, dynamic>;
            String docId = document.id;
            return ListTile(
              title: Text(data['name']),
              subtitle: Text('Calorie count: ${data['calories']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              String newName = data['name'];
                              int newCalorie = 0;
                              String newCategory = "";

                              int calories=
                              data['calories'];
                              return AlertDialog(
                                title: Text('Edit Recipe Details'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      onChanged: (value) {
                                        newName = value;
                                      },
                                      decoration: InputDecoration(
                                        hintText:
                                        'Enter new name',
                                      ),
                                      controller:
                                      TextEditingController(
                                          text: data['name']),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    TextField(
                                      onChanged: (value) {
                                        newCalorie = int.parse(value);
                                      },
                                      decoration: InputDecoration(
                                        hintText:
                                        'Enter new calorie count',
                                      ),
                                      controller:
                                      TextEditingController(
                                          text: '$calories' ),                                    ),

                                    TextField(
                                      onChanged: (value) {
                                        newCategory = value;
                                      },
                                      decoration: InputDecoration(
                                        hintText:
                                        'Enter new Category',
                                      ),
                                      controller:
                                      TextEditingController(
                                          text: data[
                                          'category']),
                                    ),

                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        firestoreManager.updateRecipe(
                                            newName,
                                            newCalorie,
                                            newCategory);
                                        Navigator.of(context)
                                            .pop();
                                      },
                                      child:
                                      Text("Update the details"))
                                ],
                              );
                            });
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        firestoreManager.deleteRecipe(data['name']);
                      },
                      icon: Icon(Icons.delete))
                ],
              ),
            );
          }).toList());
    }
    );
  }
}
