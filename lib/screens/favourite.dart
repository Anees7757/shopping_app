import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/data_service/data_prefrences.dart';
import 'package:shopping_app/screens/product_detail.dart';

class Fav extends StatefulWidget {
  const Fav({Key? key}) : super(key: key);

  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
    Favtitlelst = DataSharedPrefrences.getFavTitle();
    Favpricelst = DataSharedPrefrences.getFavPrice();
    Favimglst = DataSharedPrefrences.getFavImgUrl();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (Favtitlelst.isEmpty) ? Colors.white : Colors.grey[200],
      body: (Favtitlelst.isEmpty)
          ? Center(
              child: Lottie.asset(
                'assets/animation.json',
                height: 300,
                width: 300,
                controller: _controller,
                repeat: true,
                reverse: true,
                animate: true,
                onLoaded: (composition) {
                  _controller!
                    ..duration = composition.duration
                    ..repeat();
                },
              ),
            )
          : Column(
              children: [
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                      itemCount: Favtitlelst.length,
                      itemBuilder: (BuildContext context, index) {
                        return SafeArea(
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 5, right: 5),
                                    height: 100,
                                    child: Card(
                                      elevation: 4.0,
                                      shadowColor: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: ListTile(
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: AspectRatio(
                                            aspectRatio: 1.2,
                                            child: Image.network(
                                              Favimglst[index],
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return Center(
                                                  child: Icon(
                                                      Icons.broken_image,
                                                      size: 60,
                                                      color: Colors.grey),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        title: Text(Favtitlelst[index],
                                            maxLines: 3,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            )),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProductDetail(title:
                                                "${Favtitlelst[index]}", img: "${Favimglst[index]}", price: "${Favpricelst[index]}", index: index)
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(-6.0, -11.0, 0.0),
                                child: IconButton(
                                  icon: Icon(CupertinoIcons.clear_circled_solid,
                                      color: Colors.red, size: 32),
                                  onPressed: () async {
                                    setState(() {
                                      Favtitlelst.removeAt(index);
                                      Favpricelst.removeAt(index);
                                      Favimglst.removeAt(index);
                                    });
                                    await DataSharedPrefrences.setFavTitle(
                                        Favtitlelst);
                                    await DataSharedPrefrences.setFavPrice(Favpricelst);
                                    await DataSharedPrefrences.setFavImgUrl(
                                        Favimglst);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
    );
  }
}
