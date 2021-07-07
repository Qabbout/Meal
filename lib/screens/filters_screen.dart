import 'package:flutter/material.dart';
import 'package:meal/widgets/main_drawer.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = 'filters_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
      ),
      body: Center(
        child: Text("Filters"),
      ),
      drawer: MainDrawer(),
    );
  }
}
