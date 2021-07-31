import 'package:flutter/material.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:meal/providers/theme_provider.dart';
import 'package:meal/screens/category_meals_screen.dart';
import 'package:meal/screens/filters_screen.dart';
import 'package:meal/screens/tabs_screen.dart';
import 'package:meal/screens/meal_detail_screen.dart';
import 'package:meal/screens/themes_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (BuildContext context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<MealProvider>(
          create: (BuildContext context) => MealProvider(),
      )
      ],
    child: MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var primaryColor = Provider.of<ThemeProvider>(context).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context).accentColor;
    var themeMode = Provider.of<ThemeProvider>(context).themeMode;
    return MaterialApp(
      title: 'Meal',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: accentColor,
        canvasColor: Color.fromRGBO(255, 254, 229, 1.0),
        fontFamily: 'Raleway',
        buttonColor: Color.fromRGBO(20, 50, 50, 1),
        cardColor: Colors.white,
        shadowColor: Colors.white54,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              headline6: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      darkTheme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: accentColor,
        // canvasColor: Color.fromRGBO(229, 228, 224, 1.0),
        canvasColor: Color.fromRGBO(14, 22, 33, 1.0),
        fontFamily: 'Raleway',
        unselectedWidgetColor: Colors.white70,
        buttonColor: Colors.white70,
        cardColor: Color.fromRGBO(35, 34, 39, 1),
        shadowColor: Colors.white54,
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: TextStyle(color: Colors.white60),
              bodyText2: TextStyle(color: Colors.white60),
              headline6: TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (context) => TabsScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
        MealDetail.routeName: (context) => MealDetail(),
        FiltersScreen.routeName: (context) => FiltersScreen(),
        ThemesScreen.routeName: (context) => ThemesScreen(),
      },
    );
  }
}
