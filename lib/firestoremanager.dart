import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';


class FirestoreManager {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

    void createUser($username,$email,$password, $firstname) async {
    try {
      // i want to add users first name and last name on the cloud
      await firestore.collection('users').doc($username).set({
        'username': $username,
        'email': $email,
        'password': $password,
        'firstname': $firstname
      });
    } catch (e) {
      print(e);
    }
  }

  void retrieveUser() async {
    // Snapshot is the data from the document from the firestore
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
      await firestore.collection('users').doc('testUser').get();
      print(documentSnapshot.data());
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


