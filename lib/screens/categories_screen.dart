import 'package:flutter/material.dart';
import 'package:meal/dummy_data.dart';
import 'package:meal/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: DUMMY_CATEGORIES
          .map((categoryData) => CategoryItem(
              categoryData.id, categoryData.title, categoryData.color))
          .toList(),
    );
  }
}
