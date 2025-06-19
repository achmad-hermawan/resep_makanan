import 'package:flutter/material.dart';
import '../models/meal_model.dart';

class FavoriteProvider with ChangeNotifier {
  final List<Meal> _favorites = [];

  List<Meal> get favorites => _favorites;

  void toggleFavorite(Meal meal) {
    if (_favorites.contains(meal)) {
      _favorites.remove(meal);
    } else {
      _favorites.add(meal);
    }
    notifyListeners();
  }

  bool isFavorite(Meal meal) {
    return _favorites.contains(meal);
  }
}
