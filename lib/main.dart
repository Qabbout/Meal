import 'package:flutter/material.dart';
import 'package:meal/dummy_data.dart';
import 'package:meal/screens/category_meals_screen.dart';
import 'package:meal/screens/filters_screen.dart';
import 'package:meal/screens/tabs_screen.dart';
import 'package:meal/screens/meal_detail_screen.dart';

import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegeterian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritesMeals = [];

  void _setFilters(Map<String, bool> _filterData) {
    setState(() {
      _filters = _filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) return false;
        if (_filters['lactose']! && !meal.isLactoseFree) return false;
        if (_filters['vegan']! && !meal.isVegan) return false;
        if (_filters['vegeterian']! && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.lightGreenAccent,
        canvasColor: Color.fromRGBO(229, 228, 224, 1.0),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(49, 49, 49, 1.0),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(49, 49, 49, 1.0),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (context) => TabsScreen(_favoritesMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetail.routeName: (context) => MealDetail(),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },
    );
  }
}
