import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:meal/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category_meal';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> categoryMeals;

  @override
  void didChangeDependencies() {
    final List<Meal> availableMeals =
        Provider.of<MealProvider>(context).availableMeals;
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title'];
    categoryMeals = availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: categoryMeals.length > 0
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: width <= 400 ? 400 : 500,
                childAspectRatio: isLandscape
                    ? width / (width * 0.8)
                    : width / (width * 0.71),
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemBuilder: (ctx, index) {
                return MealItem(
                  id: categoryMeals[index].id,
                  title: categoryMeals[index].title,
                  affordability: categoryMeals[index].affordability,
                  duration: categoryMeals[index].duration,
                  complexity: categoryMeals[index].complexity,
                  imageUrl: categoryMeals[index].imageUrl,
                );
              },
              itemCount: categoryMeals.length,
            )
          : Center(
              child: Text(
                "No Meals Found",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
    );
  }
}
