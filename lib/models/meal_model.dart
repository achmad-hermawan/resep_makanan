class Meal {
  final String name;
  final String image;
  final String instructions;

  Meal({
    required this.name,
    required this.image,
    required this.instructions,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      name: json['strMeal'],
      image: json['strMealThumb'],
      instructions: json['strInstructions'],
    );
  }
}
