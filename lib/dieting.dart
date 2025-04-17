import 'package:final_project_newest/firestoremanager.dart';
import 'package:flutter/material.dart';
import 'coolthing.dart';

class Dieting extends StatefulWidget {
  const Dieting({super.key});

  @override
  State<Dieting> createState() => _DietingState();
}

class _DietingState extends State<Dieting> {
  String username = '';
  var diet = '';
  List recipes = [];

  void initState() {
    super.initState();
    // This function runs automatically when the page loads
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is String && username.isEmpty) {
      // Only do this once to avoid running again on rebuild
      username = args;

      // Now that username is available, load the diet
      loadData();
    }
  }

  Future<void> loadData() async {
    FirestoreManager firestoreManager = new FirestoreManager();
    diet = await getDiet();
    recipes = firestoreManager.retrieveRecipes();

    setState(() {}); // This will rebuild the UI if needed
  }

  Future<String> getDiet() async {
    FirestoreManager firestore = new FirestoreManager();
    var user = await firestore.retrieveUser(username);
    if(user['diet']=="WeightGain"){
      return "WeightGain";
    }else{
      return "WeightLoss";
    }

  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _name = new TextEditingController();
    TextEditingController _category = new TextEditingController();
    TextEditingController _calories = new TextEditingController();

    return Scaffold(

        appBar: AppBar(
          title: Text("Dieting"),
        ),
        body: Container(
          child: Column(

            children: [
              Text(diet),
                  new noice(),



                  /*GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 3/2
                      ),
                      itemBuilder: (context,index){
                        final recipe = recipes[index];
                        return new noice();

                      }
                  )*/


              /*FirestoreListView<Recipe>(
              query: recipesCollection.orderBy('category'),
              itemBuilder: (context, snapshot) {
                Recipe recipe = snapshot.data();
                return Text(recipe.name);
              },
            )*/

            ],

          ),

        ),
      floatingActionButton: FloatingActionButton(onPressed: (){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                  "Add Recipe"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                        decoration: const InputDecoration(
                          hintText:
                          'Enter Dish name',
                        ),
                        controller: _name
                    ),
                    TextField(
                        decoration: const InputDecoration(
                          hintText:
                          'Enter Category',
                        ),
                        controller: _category
                    ),
                    TextField(
                        decoration: const InputDecoration(
                          hintText:
                          'Enter Calorie count',
                        ),
                        controller: _calories
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      firestoreManager.createRecipe(_name.text, int.parse(_calories.text), _category.text, username);
                      Navigator.of(context)
                          .pop();

                    },
                    child: Text("Add Recipe"))
              ],
            );
          });
    },
        child: Icon(Icons.add),
    ),
    );

  }

}

class Recipe {
  Recipe({required this.name, required this.category, required this.calories});

  Recipe.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          category: json['category']! as String,
          calories: json['calories']! as double,
        );

  final String name;
  final String category;
  final double calories;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'category': category,
      'calories': calories,
    };
  }
}

FirestoreManager firestoreManager = new FirestoreManager();
final recipesCollection =
    firestoreManager.firestore.collection('recipes').withConverter<Recipe>(
          fromFirestore: (snapshot, _) => Recipe.fromJson(snapshot.data()!),
          toFirestore: (recipe, _) => recipe.toJson(),
        );



