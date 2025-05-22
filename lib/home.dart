import 'package:final_project_newest/dieting.dart';
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
        firestoreManager.resetIfNewDay(username);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<double> currentCalorie =
    firestoreManager.getCurrentCalorieCount(username);
    Future<double> totalCalorie = firestoreManager.getTotalCalorieCount(username);
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome"),
        ),
        //--------------------------------------------start drawer
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

              ListTile(//sends you to BMI calculator
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
              ListTile(//sends you to BMR calculator
                title: Row(
                  children: [Text("Calculate BMR"),Icon(Icons.calculate)],
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/bmr',
                    arguments: username,
                  );
                },
              ),
              ListTile(//sends you to saved recipes
                title: Row(
                  children: [Text("Diets"),Icon(Icons.fastfood_rounded)],
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/dieting',
                    arguments: username,
                  );
                },
              ),
              ListTile(//sends you to recipes
                title: Row(
                  children: [Text("Recipes"),Icon(Icons.fastfood_rounded)],
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/recipes',
                    arguments: username,
                  );
                },
              ),

            ],
          ),
        ),
//-----------------------------------end drawer
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // First Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 300,
                    child: Card(
                      color: Colors.greenAccent,
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.pushNamed(context, "/dieting",
                              arguments: username);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Want to get started?"),
                              Text(
                                "Add a personal recipe now!",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.fastfood),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Second Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 250,
                    child: Card(
                      color: Colors.greenAccent,
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.pushNamed(context, "/bmi",
                              arguments: username);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Calculate your BMI!",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.calculate),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    width: 250,
                    child: Card(
                      color: Colors.greenAccent,
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.pushNamed(context, "/recipe",
                              arguments: username);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Discover delicious diet meals!",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.dining),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
