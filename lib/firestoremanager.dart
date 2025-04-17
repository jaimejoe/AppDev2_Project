import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';


class FirestoreManager {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

    Future<int> createUser(username,email,password, firstname, diet) async {
      //check if the username already exists
      var data = await retrieveUser(username);
      if(data==null) {
    try {
        // i reckon we use the usernames as our id keys simply cuz its easy
        await firestore.collection('users').doc(username).set({
          'username': username,
          'email': email,
          'password': password,
          'firstname': firstname,
          'diet': diet,
        });
     return 0;
    } catch (e) {
      print(e);
    }
      }else {
        return 1;
      }
      return 2;
  }

  retrieveUser(username) async {
    // Snapshot is the data from the document from the firestore
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
      await firestore.collection('users').doc(username).get();
      return documentSnapshot.data();
    } catch (e) {
      print(e);
    }
  }

  //to be tested
  void updateUser(username,column,newdata) async {
    try {
      firestore.collection('users').doc(username).update({
        '$column': '$newdata'
      });
    }
    catch (e) {
      print(e);
    }
  }
  //to actually be made
  deleteUser(username) async {
    // Snapshot is the data from the document from the firestore
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
      await firestore.collection('users').doc(username).get();
      return documentSnapshot.data();
    } catch (e) {
      print(e);
    }
  }

  //--------------------------------------------end of user area start of recipes
//this method retrieves all recipes
  retrieveRecipes() async {
    // Snapshot is the data from the document from the firestore
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('collection');
    try {
      QuerySnapshot querySnapshot = await _collectionRef.get();
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      return allData;
    } catch (e) {
      print(e);
    }
  }


//this method retrieves a single recipe
  retrieveRecipe(name) async {
    // Snapshot is the data from the document from the firestore
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
      await firestore.collection('recipes').doc(name).get();
      return documentSnapshot.data();
    } catch (e) {
      print(e);
    }
  }

  void updateRecipe(name,calories,category) async {
    try {
      await firestore.collection('recipes').doc(name).update({
        'calories': calories,
        'category': category,
      });
    }
    catch (e) {
      print(e);
    }
  }

}


