class Recipe {
  final String id;
  final String name;
  final String images;
  final String category;
  final String instructions;

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
        id: json['idMeal'] as String,
        name: json['strMeal'] as String,
        images: json['strMealThumb'] as String,
        category: json['strCategory'] as String,
        instructions: json['strInstructions'] as String);
  }

  Recipe(
      {required this.id,
        required this.name,
        required this.images,
        required this.category,
        required this.instructions});

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe {id:$id, name: $name, image: $images, category: $category, instructions: $instructions}';
  }
}