import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:meal/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var width = MediaQuery.of(context).size.width;
    final List<Meal> _favoritesMeals =
        Provider.of<MealProvider>(context, listen: true).favoritesMeals;
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
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: width <= 400 ? 400 : 500,
          childAspectRatio:
              isLandscape ? width / (width * 0.8) : width / (width * 0.71),
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
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
