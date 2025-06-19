import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal_model.dart';

class ApiService {
  static Future<List<Meal>> fetchMeals(String query) async {
    final url = 'https://www.themealdb.com/api/json/v1/1/search.php?s=$query';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List mealsJson = data['meals'] ?? [];
      return mealsJson.map((json) => Meal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch meals');
    }
  }
}
