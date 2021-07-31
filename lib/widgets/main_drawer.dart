import 'package:flutter/material.dart';
import 'package:meal/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile({
    // required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(context).buttonColor,
      ),
      title: Text(
        "$title",
        style: TextStyle(
            fontSize: 24,
            fontFamily: 'RobotoCendensed',
            fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            alignment: Alignment.center,
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
            context: context
          ),
          buildListTile(
            context: context,
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
