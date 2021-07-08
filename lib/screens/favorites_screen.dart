import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoritesMeals;

  const FavoritesScreen(this._favoritesMeals);

  @override
  Widget build(BuildContext context) {
    if (_favoritesMeals.isEmpty)
      return Center(

        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Text(
            "You have no favorites yet, start adding now!",
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
      );
    else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _favoritesMeals[index].id,
            title: _favoritesMeals[index].title,
            affordability: _favoritesMeals[index].affordability,
            duration: _favoritesMeals[index].duration,
            complexity: _favoritesMeals[index].complexity,
            imageUrl: _favoritesMeals[index].imageUrl,
          );
        },
        itemCount: _favoritesMeals.length,
      );
    }
  }
}
