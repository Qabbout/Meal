import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoritesMeals;

  const FavoritesScreen(this._favoritesMeals);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Favorites"),
    );
  }
}
