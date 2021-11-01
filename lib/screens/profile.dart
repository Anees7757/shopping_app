import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/screens/edit.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(auth.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
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
                                foregroundImage: NetworkImage("${data['url']}"),
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
                      child: Text("${data['name']}",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w800)),
                    ),
                    Center(
                      child: Text("${data['phone']}",
                              style: TextStyle(fontSize: 17)),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Edit Profile'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditPage()),
                              );
                            },
                          ),
                    Divider(),
                    ListTile(
                            leading: Icon(Icons.map),
                            title: Text("Address"),
                            subtitle: Text('${data['address']}'),
                          ),
                    Divider(),
                    ListTile(
                            leading: Icon(Icons.credit_card),
                            title: Text('Payment Detail'),
                          ),
                    Divider(),
                    ListTile(
                            leading: Icon(Icons.logout, color: Colors.red),
                            title: Text('Logout',
                                style: TextStyle(color: Colors.red)),
                            onTap: () {
                              auth.signOut();
                            },
                          ),
                  ],
                ),
              ),
            );
          }
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        });
  }
}
