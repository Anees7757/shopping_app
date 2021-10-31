import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopping_app/main.dart';

class TabCategories {
  tabCategories(List lst) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 2,
                ),
               subCategoryContainer(lst[0]),
                const SizedBox(
                  width: 10,
                ),
                subCategoryContainer(lst[1]),
                const SizedBox(
                  width: 10,
                ),
                subCategoryContainer(lst[2]),
                const SizedBox(
                  width: 10,
                ),
                subCategoryContainer(lst[3]),
                const SizedBox(
                  width: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

 subCategoryContainer(String txt){
  return Container(
    height: 40,
    width: 110,
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 2,
          spreadRadius: 1,
          offset: Offset(1,1),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(txt, style: const TextStyle(
            color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
      ],
    ),
  );
}