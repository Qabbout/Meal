import 'package:flutter/material.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:meal/providers/theme_provider.dart';
import 'package:meal/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = 'filters_screen';
  

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {



  Widget builSwitchListTile({
    required String title,
    required String description,
    required bool currentValue,
    required VoidCallback? updateValue(bool newVal),
  }) {
    return SwitchListTile(
      value: currentValue,
      onChanged: updateValue,
      title: Text("$title"),
      subtitle: Text("$description"),
      inactiveTrackColor:
          Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
              ? null
              : Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
     final Map<String, bool> currentFilters = Provider.of<MealProvider>(
      context,
    ).filters;
     

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
         ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your mail selection",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                builSwitchListTile(
                    title: "Gluten Free",
                    description: "Only include gluten free meals",
                    currentValue: currentFilters['gluten']!,
                    updateValue: (newVal) {
                        currentFilters['gluten'] = newVal;
                      Provider.of<MealProvider>(
                        context,
                        listen: false,
                      ).setFilters();
                    }),
                builSwitchListTile(
                    title: "Lactose Free",
                    description: "Only include lactose free meals",
                    currentValue: currentFilters['lactose']!,
                    updateValue: (newVal) {
                        currentFilters['lactose'] = newVal;
                      Provider.of<MealProvider>(
                        context,
                        listen: false,
                      ).setFilters();
                    }),
                builSwitchListTile(
                    title: "Vegan",
                    description: "Only include Vegan meals",
                    currentValue: currentFilters['vegan']!,
                    updateValue: (newVal) {
                        currentFilters['vegan'] = newVal;
                      Provider.of<MealProvider>(
                        context,
                        listen: false,
                      ).setFilters();
                    }),
                builSwitchListTile(
                    title: "Vegeterian",
                    description: "Only include vegeterian meals",
                    currentValue: currentFilters['vegeterian']!,
                    updateValue: (newVal) {
                        currentFilters['vegeterian'] = newVal;
                      Provider.of<MealProvider>(
                        context,
                        listen: false,
                      ).setFilters();
                    }),
              ],
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
