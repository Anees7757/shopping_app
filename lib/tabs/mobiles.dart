import 'package:flutter/material.dart';

import '../tab_categories.dart';

class Mobiles extends StatefulWidget {
  const Mobiles({Key? key}) : super(key: key);

  @override
  _MobilesState createState() => _MobilesState();
}

class _MobilesState extends State<Mobiles> {

  List<String> mobilesList = [
    'Samsung' , 'Iphone', 'Nokia', 'Infinix',
  ];

  @override
  Widget build(BuildContext context) {
    return TabCategories().tabCategories(mobilesList);
  }
}
