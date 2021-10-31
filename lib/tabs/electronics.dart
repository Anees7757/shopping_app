import 'package:flutter/material.dart';
import 'package:shopping_app/tab_categories.dart';

class Electronics extends StatefulWidget {
  const Electronics({Key? key}) : super(key: key);

  @override
  _ElectronicsState createState() => _ElectronicsState();
}

class _ElectronicsState extends State<Electronics> {

  List<String> electronicList = [
    'TV' , 'LED' , 'FANS' , 'AC',
  ];

  @override
  Widget build(BuildContext context) {
    return TabCategories().tabCategories(electronicList);
  }
}