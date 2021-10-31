import 'package:flutter/material.dart';

import '../tab_categories.dart';

class Groceries extends StatefulWidget {
  const Groceries({Key? key}) : super(key: key);

  @override
  _GroceriesState createState() => _GroceriesState();
}

class _GroceriesState extends State<Groceries> {

  List<String> groceryList = [
    'Fruit' , 'Vegetables', 'Meat', 'Spices',
  ];

  @override
  Widget build(BuildContext context) {
    return TabCategories().tabCategories(groceryList);
  }
}
