import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/screens/search.dart';
import 'package:shopping_app/tabs/Cars.dart';
import 'package:shopping_app/tabs/all.dart';
import 'package:shopping_app/tabs/clothes.dart';
import 'package:shopping_app/tabs/electronics.dart';
import 'package:shopping_app/tabs/groceries.dart';
import 'package:shopping_app/tabs/mobiles.dart';

import '../main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _addressController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  dialogbox() {
    final String address = _addressController.text;
    final userId = auth.currentUser!.uid;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Address'),
            content: TextField(
              controller: _addressController,
              decoration: InputDecoration(hintText: "Address here"),
            ),
            actions: <Widget>[
              FlatButton(
                color: primaryColor,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() async {
                    await db
                        .collection("users")
                        .doc(userId)
                        .update({"address": address});
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
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
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Search()),
                  );
                },
                textAlignVertical: TextAlignVertical.bottom,
                autofocus: false,
                cursorColor: Theme.of(context).primaryColor,
                style:
                    const TextStyle(fontSize: 14.0, color: Color(0xFFbdc6cf)),
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
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.segment),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          }),
          bottom: const TabBar(
            isScrollable: true,
            indicatorWeight: 4,
            unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(text: "All"),
              Tab(text: "Electronics"),
              Tab(text: "Cars"),
              Tab(text: "Mobiles"),
              Tab(text: "Groceries"),
              Tab(text: "Clothes"),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.local_mall),
                    SizedBox(
                      width: 3,
                    ),
                    Text("Shopping App",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ],
                ),
                subtitle: Text("Get everything here!"),
              ),
              Divider(
                color: primaryColor,
              ),
              ListTile(
                title: Text("Old Previous Orders"),
                leading: Icon(Icons.undo),
              ),
              ListTile(
                title: Text("Edit Address"),
                leading: Icon(Icons.edit),
                onTap: () {
                  dialogbox();
                },
              ),
              ListTile(
                title: Text("About"),
                leading: Icon(Icons.info),
              ),
              ListTile(
                title: Text("Policies"),
                leading: Icon(Icons.policy),
              ),
            ],
          ),
        ),
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: const TabBarView(
            children: <Widget>[
              All(),
              Electronics(),
              Cars(),
              Mobiles(),
              Groceries(),
              Clothes(),
            ],
          ),
        ),
      ),
    );
  }
}
