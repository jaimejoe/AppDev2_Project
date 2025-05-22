import 'package:flutter/material.dart';
import 'recipe.api.dart';
import 'recipe.dart';
import 'recipecard.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  String username = '';
  void showDescriptionDialog(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Recipe Description"),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute
        .of(context)
        ?.settings
        .arguments;
    if (args != null && args is String) {
      setState(() {
        username = args;
      });
    }
  }

  List<Recipe> _recipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Recipe> recipes;
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipes"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
          itemCount: _recipes.length,
          itemBuilder: (context, index) {
            return RecipeCard(
              recipe: _recipes[index],
            );
          }),
    );
  }
}