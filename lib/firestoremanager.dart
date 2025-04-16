import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';


class FirestoreManager {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

    Future<int> createUser($username,$email,$password, $firstname) async {
      //check if the username already exists
      var data = await retrieveUser($username);
      if(data==null) {
    try {
        // i reckon we use the usernames as our id keys simply cuz its easy
        await firestore.collection('users').doc($username).set({
          'username': $username,
          'email': $email,
          'password': $password,
          'firstname': $firstname
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

  retrieveUser($username) async {
    // Snapshot is the data from the document from the firestore
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
      await firestore.collection('users').doc($username).get();
      return documentSnapshot.data();
    } catch (e) {
      print(e);
    }
  }

  void updateUser() async {
    try {
      firestore.collection('users').doc('testUser').update({
        'FirstName': 'Alan'
      });
    }
    catch (e) {
      print(e);
    }
  }
}


