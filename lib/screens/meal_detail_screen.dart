import 'package:flutter/material.dart';
import 'package:meal/dummy_data.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class MealDetail extends StatelessWidget {
  static const routeName = 'meal_details';
 

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(
      {required Widget child, required BuildContext context}) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(10),
        height: isLandscape ? height * 0.5 : height * 0.25,
        width: isLandscape ? (width * 0.5 - 30) : width,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    var accentColor = Theme.of(context).accentColor;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

var lvIngredients = ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        selectedMeal.ingredients[index],
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                },
              );

    var lvSteps = ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          selectedMeal.steps[index],
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color),
                        ),
                        leading: CircleAvatar(
                          
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text("#${index + 1}",
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              )),
                        ),
                      ),
                      Divider()
                    ],
                  );
                },
              );

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Provider.of<MealProvider>(context).isMealFavorite(mealId)
              ? Icons.star
              : Icons.star_border,
        ),
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .toggleFavorite(mealId),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Hero(
                tag: mealId,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      buildSectionTitle(context, "Ingredients"),
                      buildContainer(child: lvIngredients, context: context),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      buildSectionTitle(context, "Steps"),
                      buildContainer(child: lvSteps, context: context),
                    ],
                  )
                ],
            ),
            if (!isLandscape) buildSectionTitle(context, "Ingredients"),
            if (!isLandscape)
              buildContainer(child: lvIngredients, context: context),
            if (!isLandscape) buildSectionTitle(context, "Steps"),
            if (!isLandscape) buildContainer(child: lvSteps, context: context),
           
          ],
        ),
      ),
    );
  }
}
