import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        titleSpacing: 0,
        title: Container(
            height: 35,
            margin: EdgeInsets.only(right: 20),
            child: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              autofocus: true,
              cursorColor: Theme.of(context).primaryColor,
              style: const TextStyle(fontSize: 14.0, color: Color(0xFFbdc6cf)),
              decoration: InputDecoration(
                prefixIcon: const Icon(CupertinoIcons.search),
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Search',
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
      ),
      body: Center(
        child: Text("Nothing to show here!"),
      ),
    );
  }
}
