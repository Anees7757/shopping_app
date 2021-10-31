import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController nameInputController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController pwdInputController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? emailValidator(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value!)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String? pwdValidator(String? value) {
    if (value!.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  String imagePath = '';
  File? imageFile;

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = image!.path;
      imageFile = File(imagePath);
    });
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future register() async {
    final String name = nameInputController.text;
    final String phone = phoneController.text;
    final String email = emailInputController.text;
    final String password = pwdInputController.text;
    final String address = addressController.text;

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/${DateTime.now().toString()}.jpeg');

    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      File file = File(imagePath);
      await ref.putFile(file);
      String downloadUrl = await ref.getDownloadURL();

      await db.collection("users").doc(user?.uid).set({
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "url": downloadUrl,
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );

      final snackBar = SnackBar(content: Text('Account Created'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      nameInputController.clear();
      phoneController.clear();
      emailInputController.clear();
      pwdInputController.clear();
      addressController.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        final snackBar =
            SnackBar(content: Text('The password provided is too weak.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'email-already-in-use') {
        final snackBar = SnackBar(
            content: Text(
                'email-already-in-use\nThe account already exists for that email.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: _registerFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: (imageFile != null)
                              ? ClipRRect(
                                  child:
                                      Image.file(imageFile!, fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(50),
                                )
                              : Icon(CupertinoIcons.person, size: 35),
                        ),
                        TextButton(
                          onPressed: () {
                            getImage();
                          },
                          child: Text("Select Avatar"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Full Name*'),
                          controller: nameInputController,
                          validator: (value) {
                            if (value!.length < 4) {
                              return "Please enter a valid first name.";
                            }
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Phone*', hintText: "923XXXXXXXX"),
                          controller: phoneController,
                          validator: (value) {
                            if (value!.length < 10) {
                              return "Please enter a valid phone number";
                            }
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Email*', hintText: "abc@example.com"),
                          controller: emailInputController,
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                        ),
                        TextFormField(
                          obscureText: _passwordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password*',
                            hintText: "********",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey[700],
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          controller: pwdInputController,
                          validator: pwdValidator,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Address',
                              hintText: "Islamabad, Pakistan"),
                          controller: addressController,
                          minLines: 1,
                          maxLines: 5,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          child: Text("Register"),
                          color: primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            if (_registerFormKey.currentState!.validate()) {
                              final snackBar = SnackBar(
                                  content: Text('Wait Please!'),
                                  duration: Duration(seconds: 10));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              register();
                            }
                          },
                        ),
                        Text("Already have an account?"),
                        FlatButton(
                          child: Text("Login here!"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
