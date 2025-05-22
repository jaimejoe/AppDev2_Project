import 'package:flutter/material.dart';
import 'firestoremanager.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirestoreManager firestoreManager = FirestoreManager();
  String username = '';
  double _totalCalorieCount = 0;
  double _currentCalorieCount = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchCalorieCounts() async {
    double totalCalories =
        await firestoreManager.getTotalCalorieCount(username);
    double currentCalories =
        await firestoreManager.getCurrentCalorieCount(username);
    print("Total Calories: $totalCalories");
    print("Current Calories: $currentCalories");
    setState(() {
      _totalCalorieCount = totalCalories;
      _currentCalorieCount = currentCalories;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      setState(() {
        username = args;
      });
      _fetchCalorieCounts(); // Fetch calorie counts after setting username
    }
  }

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
              height: 200,
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "BMI:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: FutureBuilder<double>(
                        future: firestoreManager.getBMI(username),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Loading...");
                          } else if (snapshot.hasError) {
                            return const Text("Error fetching BMI");
                          } else if (!snapshot.hasData) {
                            return const Text("No BMI data found");
                          } else {
                            final bmi = snapshot.data!;
                            return Text("${bmi.toStringAsFixed(1)}");
                          }
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "BMR/Calorie Maintenance:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: FutureBuilder<double>(
                        future: firestoreManager.getTotalCalorieCount(username),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Loading...");
                          } else if (snapshot.hasError) {
                            return const Text("Error fetching BMR");
                          } else if (!snapshot.hasData) {
                            return const Text("No BMR data found");
                          } else {
                            final bmr = snapshot.data!;
                            return Text(
                                "${bmr.toStringAsFixed(0)} calories/day");
                          }
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Diet Type:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: FutureBuilder<String>(
                        future: firestoreManager.getDietType(username),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Loading...");
                          } else if (snapshot.hasError) {
                            return const Text("Error fetching BMR");
                          } else if (!snapshot.hasData) {
                            return const Text("No BMR data found");
                          } else {
                            final diet = snapshot.data!;
                            return Text("$diet");
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 200,
              width: 300,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: 2,
                      // Adjust this value to make it bigger (2 = 2x size)
                      child: CircularProgressIndicator(
                        value: _totalCalorieCount > 0
                            ? _currentCalorieCount / _totalCalorieCount
                            : 0,
                        strokeWidth: 10, // You can also increase this value
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                      ),
                    ),
                    SizedBox(height: 30), // Add some spacing

                    Text('Current Calories: $_currentCalorieCount'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
