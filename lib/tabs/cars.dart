import 'package:flutter/material.dart';

import '../tab_categories.dart';

class Cars extends StatefulWidget {
  const Cars({Key? key}) : super(key: key);

  @override
  _CarsState createState() => _CarsState();
}

class _CarsState extends State<Cars> {

  List<String> carsList = [
    'Honda' , 'Toyota', 'Tesla', 'BMW',
  ];

  @override
  Widget build(BuildContext context) {
    return TabCategories().tabCategories(carsList);
  }
}
