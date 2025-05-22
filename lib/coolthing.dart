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

  String username = '';
  int selectedOption = 1;
  String dietChoice = '';
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
    final Stream<QuerySnapshot> _userStream = firestoreManager.firestore
        .collection('recipes')
        .where('username', isEqualTo: username)
        .snapshots();
    return SingleChildScrollView(
        child: StreamBuilder(
            stream: _userStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              // this is to manipulate live data
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading...");
              }
              //hi
              return ListView(
                  shrinkWrap: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    String docId = document.id;
                    return ListTile(
                      title: Text(data['name']),
                      subtitle: Text('Calorie count: ${data['calories']} | Category ${data['category']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                firestoreManager.addToCurrentCalorie(
                                    username, data['calories']);
                                final addSnackBar = SnackBar(
                                    content: Text(
                                        "Added ${data['name']} with ${data['calories']} calories"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(addSnackBar);
                              },
                              icon: Icon(Icons.add)),
                          IconButton(
                              onPressed: () {
                                String newName = data['name'];
                                int newCalorie = data['calories'];
                                String newCategory = data['category'];
                                int tempSelectedOption = newCategory == 'WeightGain' ? 1 : 2;

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder: (context, setState) {
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
                                                    hintText: 'Enter new name',
                                                  ),
                                                  controller: TextEditingController(
                                                      text: data['name']),
                                                ),
                                                SizedBox(height: 10),
                                                TextField(
                                                  onChanged: (value) {
                                                    newCalorie = int.tryParse(value) ?? newCalorie;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: 'Enter new calorie count',
                                                  ),
                                                  controller: TextEditingController(
                                                      text: data['calories'].toString()),
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Radio<int>(
                                                      value: 1,
                                                      groupValue: tempSelectedOption,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          tempSelectedOption = value!;
                                                          newCategory = "WeightGain";
                                                        });
                                                      },
                                                    ),
                                                    Text('Weight Gain'),
                                                    SizedBox(width: 20),
                                                    Radio<int>(
                                                      value: 2,
                                                      groupValue: tempSelectedOption,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          tempSelectedOption = value!;
                                                          newCategory = "FatLoss";
                                                        });
                                                      },
                                                    ),
                                                    Text('Fat Loss'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    firestoreManager.updateRecipe(
                                                        docId,
                                                        newName,
                                                        newCalorie,
                                                        newCategory);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Update"))
                                            ],
                                          );
                                        },
                                      );
                                    });
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                firestoreManager.deleteRecipe(docId);
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    );
                      }).toList());
                }));
  }
}