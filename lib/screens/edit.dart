import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  File? _image;

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image as File?;
      final userId = auth.currentUser!.uid;
      db.collection("users").doc(userId).set({"image": (context) => _image});
    });
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  txtField(IconData _icon, String _hintTxt, int maxLines,
      TextInputType inputType, TextEditingController _controller) {
    return TextField(
      controller: _controller,
      maxLines: maxLines,
      minLines: 1,
      decoration: InputDecoration(
        focusColor: primaryColor,
        hoverColor: primaryColor,
        // border: OutlineInputBorder(),
        prefixIcon: Icon(_icon),
        hintText: _hintTxt,
      ),
      keyboardType: inputType,
    );
  }

  Future update() async {
    final String name = _nameController.text;
    final String pwd = _pwdController.text;
    final String phone = _phoneController.text;
    final String address = _addressController.text;

    final userId = auth.currentUser!.uid;

    if (name.isNotEmpty) {
      await db.collection("users").doc(userId).update({"name": name});
    }
    if (pwd.isNotEmpty) {
      await auth.currentUser!.updatePassword(pwd);
    }
    if (phone.isNotEmpty) {
      await db.collection("users").doc(userId).update({"phone": phone});
    }
    if (address.isNotEmpty) {
      await db.collection("users").doc(userId).update({"address": address});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: Text("Edit Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              txtField(CupertinoIcons.person, 'Full Name', 1,
                  TextInputType.name, _nameController),
              SizedBox(
                height: 20,
              ),
              txtField(CupertinoIcons.lock, 'Password', 1,
                  TextInputType.visiblePassword, _pwdController),
              SizedBox(
                height: 20,
              ),
              txtField(CupertinoIcons.phone, 'Phone Number', 1,
                  TextInputType.number, _phoneController),
              SizedBox(
                height: 20,
              ),
              txtField(CupertinoIcons.map, 'Address', 5, TextInputType.none,
                  _addressController),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                color: primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    update();
                    final snackBar = SnackBar(content: Text('Profile Updated'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                    _nameController.clear();
                    _pwdController.clear();
                    _phoneController.clear();
                    _addressController.clear();
                  });
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
