import 'package:flutter/material.dart';
import 'package:meal/models/category.dart';
import 'package:meal/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  List<String> prefsMealId = [];
  List<Category> availableCategories = DUMMY_CATEGORIES;

  bool isMealFavorite(String mealId) {
    return favoritesMeals.any((meal) => meal.id == mealId);
  }

  void setFilters() async {
    availableMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten']! && !meal.isGlutenFree) return false;
      if (filters['lactose']! && !meal.isLactoseFree) return false;
      if (filters['vegan']! && !meal.isVegan) return false;
      if (filters['vegeterian']! && !meal.isVegetarian) return false;
      return true;
    }).toList();

    List<Category> ac = [];
    availableMeals.forEach(
      (meal) {
        meal.categories.forEach(
          (categoryId) {
            DUMMY_CATEGORIES.forEach(
              (category) {
                if (categoryId == category.id) {
                  if (!ac.any((category) => category.id == categoryId))
                    ac.add(category);
                }
              },
            );
          },
        );
      },
    );
    availableCategories = ac;

    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("gluten", filters['gluten']!);
    prefs.setBool("lactose", filters['lactose']!);
    prefs.setBool("vegan", filters['vegan']!);
    prefs.setBool("vegeterian", filters['vegeterian']!);
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool("gluten") ?? false;
    filters['lactose'] = prefs.getBool("lactose") ?? false;
    filters['vegan'] = prefs.getBool("vegan") ?? false;
    filters['vegeterian'] = prefs.getBool("vegeterian") ?? false;

    prefsMealId = prefs.getStringList("prefsMealId") ?? [];
    for (var mealId in prefsMealId) {
      favoritesMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    }

    notifyListeners();
  }

  void toggleFavorite(String mealId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final existingIndex =
        favoritesMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      favoritesMeals.removeAt(existingIndex);
      prefsMealId.removeAt(existingIndex);
    } else {
      favoritesMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }
    notifyListeners();
    prefs.setStringList("prefsMealId", prefsMealId);
  }
}
