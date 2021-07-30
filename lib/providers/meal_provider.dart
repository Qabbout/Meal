import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';

import '../dummy_data.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegeterian': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoritesMeals = [];

  bool isMealFavorite(String mealId) {
    return favoritesMeals.any((meal) => meal.id == mealId);
  }

  void setFilters(Map<String, bool> _filterData) {
    filters = _filterData;

    availableMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten']! && !meal.isGlutenFree) return false;
      if (filters['lactose']! && !meal.isLactoseFree) return false;
      if (filters['vegan']! && !meal.isVegan) return false;
      if (filters['vegeterian']! && !meal.isVegetarian) return false;
      return true;
    }).toList();
    notifyListeners();
  }

  void toggleFavorite(String mealId) {
    final existingIndex =
        favoritesMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      favoritesMeals.removeAt(existingIndex);
    } else {
      favoritesMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    }
    notifyListeners();
  }
}
