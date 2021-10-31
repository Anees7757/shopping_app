import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/data_service/data_prefrences.dart';
import 'package:shopping_app/registration/singup.dart';

import '../main.dart';


List<String> Favtitlelst = [];
List<String> Favpricelst = [];
List<String> Favimglst = [];

List<String> Carttitlelst = [];
List<String> Cartpricelst = [];
List<String> Cartimglst = [];

class ProductDetail extends StatefulWidget {
  const ProductDetail(
      {Key? key, required this.title, required this.img, required this.price, required this.index})
      : super(key: key);
  final String title;
  final String img;
  final String price;
  final int index;

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  IconData _icon = CupertinoIcons.heart;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () async {
                setState(() {
                    if (_icon == CupertinoIcons.heart) {
                      _icon = CupertinoIcons.heart_fill;
                      Favtitlelst.add("${widget.title}");
                      Favimglst.add("${widget.img}");
                      Favpricelst.add("${widget.price}");
                      final snackBar =
                          SnackBar(content: Text('Saved as Favourite'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 5),
                        content: Text('Favourite Removed'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () async {
                            setState(() {
                              _icon = CupertinoIcons.heart_fill;
                              Favtitlelst.add("${widget.title}");
                              Favimglst.add("${widget.img}");
                              Favpricelst.add("${widget.price}");
                            });
                            await DataSharedPrefrences.setFavTitle(Favtitlelst);
                            await DataSharedPrefrences.setFavPrice(Favpricelst);
                            await DataSharedPrefrences.setFavImgUrl(Favimglst);
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      _icon = CupertinoIcons.heart;
                      Favtitlelst.removeAt(widget.index);
                      Favpricelst.removeAt(widget.index);
                      Favimglst.removeAt(widget.index);
                    }
                  });
                await DataSharedPrefrences.setFavTitle(Favtitlelst);
                await DataSharedPrefrences.setFavPrice(Favpricelst);
                await DataSharedPrefrences.setFavImgUrl(Favimglst);
              },
              child: Icon(_icon)
          ),
          SizedBox(
            width: 20
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: 400,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Card(
                child: Image.asset(widget.img, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(widget.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 20)),
            subtitle: Text(
                "${widget.title} has many features, that makes it special. ALso price efficient. So don't waste the time, get it now."),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Rs. ${widget.price} PKR",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("with 10% discount",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 60,
          ),
          ElevatedButton(
            child: Text("Add to Cart", style: TextStyle(color: Colors.white)),
            onPressed: () async {
              setState(() {
                if (auth.currentUser == null) {
                  final snackBar = SnackBar(
                    duration: Duration(seconds: 10),
                    content: Text('Signup/Login First'),
                    action: SnackBarAction(
                      label: 'Signup',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  if (_icon == CupertinoIcons.heart) {
                    _icon = CupertinoIcons.heart_fill;
                    Carttitlelst.add("${widget.title}");
                    Cartimglst.add("${widget.img}");
                    Cartpricelst.add("${widget.price}");
                    final snackBar =
                    SnackBar(content: Text('Saved in Cart'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text('Cart Removed'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () async {
                          setState(() {
                            _icon = CupertinoIcons.heart_fill;
                            Carttitlelst.add("${widget.title}");
                            Cartimglst.add("${widget.img}");
                            Cartpricelst.add("${widget.price}");
                          });
                          await DataSharedPrefrences.setCartTitle(Carttitlelst);
                          await DataSharedPrefrences.setCartPrice(Cartpricelst);
                          await DataSharedPrefrences.setCartImgUrl(Cartimglst);
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    _icon = CupertinoIcons.heart;
                    Carttitlelst.removeAt(widget.index);
                    Cartpricelst.removeAt(widget.index);
                    Cartimglst.removeAt(widget.index);
                  }
                }
              });
              await DataSharedPrefrences.setCartTitle(Carttitlelst);
              await DataSharedPrefrences.setCartPrice(Cartpricelst);
              await DataSharedPrefrences.setCartImgUrl(Cartimglst);
            },
          ),
        ],
      ),
    );
  }
}
