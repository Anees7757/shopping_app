import 'package:flutter/material.dart';
import 'package:shopping_app/registration/login.dart';
import 'package:shopping_app/registration/singup.dart';

import '../main.dart';

class Profile2 extends StatefulWidget {
  const Profile2({Key? key}) : super(key: key);

  @override
  _Profile2State createState() => _Profile2State();
}

class _Profile2State extends State<Profile2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(400),
                      bottomLeft: Radius.circular(400)),
                ),
              ),
              Center(
                child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                            blurRadius: 10),
                      ],
                    ),
                    margin: const EdgeInsets.fromLTRB(0, 110, 0, 0),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png"),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text("Unknown",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
          ),
          Center(
            child: Text("", style: TextStyle(fontSize: 17)),
          ),
          SizedBox(
            height: 70,
          ),
          ElevatedButton(
            child: Text("Register",
            style: TextStyle(
              color: Colors.white
            )),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Signup()),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(),
              Text("or"),
              Divider(),
            ],
          ),
          ElevatedButton(
            child: Text("Login",
                style: TextStyle(
                    color: Colors.white
                )),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
    );
  }
}
