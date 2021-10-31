import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/registration/singup.dart';
import 'package:shopping_app/screens/profile.dart';

import '../main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController pwdInputController = TextEditingController();

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

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future login() async {
    final String email = emailInputController.text;
    final String password = pwdInputController.text;

    try {
      final UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
      final snackBar = SnackBar(content: Text('Logged in'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      emailInputController.clear();
      pwdInputController.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        final snackBar = SnackBar(content: Text('Invalid Password'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'user-not-found') {
        final snackBar = SnackBar(content: Text('Invalid email'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else
        print(e.code);
    }
  }

  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _loginFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email*', hintText: "abc@example.com"),
                    controller: emailInputController,
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  TextFormField(
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
                    obscureText: _passwordVisible,
                    validator: pwdValidator,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    child: Text("Login"),
                    color: primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if (emailInputController.text.isEmpty ||
                          pwdInputController.text.isEmpty) {
                        final snackBar =
                        SnackBar(content: Text('Please enter data'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        login();
                      }
                    },
                  ),
                  Text("Don't have an account yet?"),
                  FlatButton(
                    child: Text("Register here!"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  bool chk = false;
}
