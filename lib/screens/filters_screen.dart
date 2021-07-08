import 'package:flutter/material.dart';
import 'package:meal/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = 'filters_screen';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  bool _lactoseFree = false;

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
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    currentValue: _glutenFree,
                    updateValue: (newVal) {
                      setState(() {
                        _glutenFree = newVal;
                      });
                    }),
                builSwitchListTile(
                    title: "Lactose Free",
                    description: "Only include lactose free meals",
                    currentValue: _lactoseFree,
                    updateValue: (newVal) {
                      setState(() {
                        _lactoseFree = newVal;
                      });
                    }),
                builSwitchListTile(
                    title: "Vegan",
                    description: "Only include Vegan meals",
                    currentValue: _vegan,
                    updateValue: (newVal) {
                      setState(() {
                        _vegan = newVal;
                      });
                    }),
                builSwitchListTile(
                    title: "Vegeterian",
                    description: "Only include vegeterian meals",
                    currentValue: _vegetarian,
                    updateValue: (newVal) {
                      setState(() {
                        _vegetarian = newVal;
                      });
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
