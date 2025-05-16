import 'dart:convert';
import 'package:http/http.dart' as http;
import 'recipe.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    // Proper URI construction
    var uri = Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=salad');

    // Await the GET request
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Decode JSON response
      Map<String, dynamic> data = jsonDecode(response.body);

      List<dynamic> meals = data['meals'];
      print(meals);

      // Convert each meal into a Recipe object

      return Recipe.recipesFromSnapshot(meals);
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
