import 'package:flutter/material.dart';

import '../tab_categories.dart';

class Clothes extends StatefulWidget {
  const Clothes({Key? key}) : super(key: key);

  @override
  _ClothesState createState() => _ClothesState();
}

class _ClothesState extends State<Clothes> {

  List<String> clothesList = [
    'Shirts' , 'Shoes', 'Pants', 'Caps',
  ];

  @override
  Widget build(BuildContext context) {
    return TabCategories().tabCategories(clothesList);
  }
}
