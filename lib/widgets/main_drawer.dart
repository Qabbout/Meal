import 'package:flutter/material.dart';
import 'package:meal/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile({
    // required BuildContext context,
    required IconData icon,
    required String title,
    required Function onTap,
  }) {
    return ListTile(
      leading: Icon(
        Icons.restaurant,
        size: 26,
      ),
      title: Text(
        "Meal",
        style: TextStyle(
            fontSize: 24,
            fontFamily: 'RobotoCendensed',
            fontWeight: FontWeight.bold),
      ),
      onTap: onTap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).accentColor,
            child: Text(
              "Cooking Up!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            icon: Icons.restaurant,
            title: "Meal",
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          buildListTile(
              icon: Icons.settings,
              title: "Filters",
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(FiltersScreen.routeName);
              }),
        ],
      ),
    );
  }
}
