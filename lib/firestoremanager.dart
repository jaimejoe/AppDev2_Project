import 'package:final_project_newest/dieting.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';

class FirestoreManager {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<int> createUser(username, email, password, firstname, diet) async {
    //check if the username already exists
    var data = await retrieveUser(username);
    if (data == null) {
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
    } else {
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

  addFavoriteRecipe(username, dishname, mealid) async {
    try {
      // i reckon we use the usernames as our id keys simply cuz its easy
      await firestore.collection('favoriteRecipes').doc().set({
        'name': dishname,
        'recipeID': mealid,
        'username': username,
      });
      return 0;
    } catch (e) {
      return 1;
      print(e);
    }
  }

  //to be tested
  Future<void> updateUser(username, column, newdata) async {
    try {
      firestore
          .collection('users')
          .doc(username)
          .update({'$column': '$newdata'});
    } catch (e) {
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
        FirebaseFirestore.instance.collection('recipes');
    try {
      QuerySnapshot querySnapshot =
          await _collectionRef.where('category', isEqualTo: 'WeightLoss').get();
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
      documentSnapshot = await firestore.collection('recipes').doc(name).get();
      return documentSnapshot.data();
    } catch (e) {
      print(e);
    }
  }

  void updateRecipe(docId, name, calories, category) async {
    try {
      await firestore.collection('recipes').doc(docId).update({
        'name': name,
        'calories': calories,
        'category': category,
      });
      print("Recipe updated successfully.");
    } catch (e) {
      print("Error updating recipe: $e");
    }
  }

  Future<void> addTotalCalorieCount(String username, double count) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(username)
          .update({
        'totalCalorieCount': count,
      });
      print('Total Calorie field added/updated successfully.');
    } catch (e) {
      print('Error updating BMR field: $e');
    }
  }

  Future<void> addBMI(String username, double bmi) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(username)
          .update({
        'bmi': bmi,
      });
      print('BMI field added/updated successfully.');
    } catch (e) {
      print('Error updating BMR field: $e');
    }
  }

  Future<double> getBMI(username) async {
    final firestore = FirebaseFirestore.instance;
    final doc = await firestore.collection('users').doc(username).get();
    final bmi = doc.data()?['bmi'];
    return bmi;
  }

  Future<double> getTotalCalorieCount(username) async {
    final firestore = FirebaseFirestore.instance;
    final doc = await firestore.collection('users').doc(username).get();
    final totalCalorieCount = doc.data()?['totalCalorieCount'];
    return totalCalorieCount;
  }

  Future<double> getCurrentCalorieCount(username) async {
    final firestore = FirebaseFirestore.instance;
    final doc = await firestore.collection('users').doc(username).get();
    final currentCalorieCount = doc.data()?['currentCalorieCount'];
    return currentCalorieCount;
  }

  Future<void> matchTotalAndCurrent(username, amount) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(username)
          .update({
        'currentCalorieCount': amount,
      });
      print('Current Calorie field added/updated successfully.');
    } catch (e) {
      print('Error updating BMR field: $e');
    }
  }

  Future<void> addToCurrentCalorie(username, amount) async {
    try {
      DocumentSnapshot doc =
          await firestore.collection('users').doc(username).get();
      Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
      String dietType = userData['diet'] ?? 'WeightLoss';

      if (dietType == 'FatLoss') {
        await doc.reference.update({
          'currentCalorieCount': FieldValue.increment(-amount),
        });
      } else if (dietType == 'WeightGain') {
        await doc.reference.update({
          'currentCalorieCount': FieldValue.increment(amount),
        });
      }
      print("Calories adjusted successfully based on diet.");
    } catch (e) {
      print("Error adjusting calories: $e");
    }
  }

  Future<String> getDietType(username) async {
    final firestore = FirebaseFirestore.instance;
    final doc = await firestore.collection('users').doc(username).get();
    final currentCalorieCount = doc.data()?['diet'];
    return currentCalorieCount;
  }

  deleteRecipe(name) async {
    // Snapshot is the data from the document from the firestore
    DocumentSnapshot documentSnapshot;
    try {
      firestore.collection('recipes').doc(name).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<void> createRecipe(name, calories, category, username) async {
    try {
      await FirebaseFirestore.instance
          .collection('recipes')
          .add({
        'name': name,
        'calories': calories,
        'category': category,
        'username': username
      });
      print('Recipe added/updated successfully.');
    } catch (e) {
      print('Error updating Recipe field: $e');
    }
  }

  Future<void> resetIfNewDay(String username) async {
    try {
      DateTime today = DateTime.now();
      DateTime todayDateOnly = DateTime(today.year, today.month, today.day);

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(username)
          .get();

      String? lastDateStr = doc.get('lastUpdatedDate');
      DateTime? lastSavedDate =
          lastDateStr != null ? DateTime.tryParse(lastDateStr) : null;

      bool isNewDay = lastSavedDate == null ||
          todayDateOnly.isAfter(
            DateTime(
                lastSavedDate.year, lastSavedDate.month, lastSavedDate.day),
          );

      if (isNewDay) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(username)
            .update({
          'currentCalorieCount': 0,
          'lastUpdatedDate': todayDateOnly.toIso8601String(),
        });
        print("New day – reset performed.");
      } else {
        print("Same day – no reset.");
      }
    } catch (e) {
      print("Error checking for new day: $e");
    }
  }
}
