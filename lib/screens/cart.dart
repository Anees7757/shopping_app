import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/data_service/data_prefrences.dart';

import 'product_detail.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> with TickerProviderStateMixin{

  AnimationController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    Carttitlelst = DataSharedPrefrences.getCartTitle();
    Cartpricelst = DataSharedPrefrences.getCartPrice();
    Cartimglst = DataSharedPrefrences.getCartImgUrl();
  }
  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return (Carttitlelst.isEmpty)
        ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/cart_animation.json',
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
          Text("Add some products in Cart"),
        ],
    )
        : Column(
      children: [
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
              itemCount: Carttitlelst.length,
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
                                      Cartimglst[index],
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
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(Carttitlelst[index],
                                        maxLines: 3,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        )),
                                    Text("RS. ${Cartpricelst[index]} PKR"),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetail(title:
                                        "${Carttitlelst[index]}", img: "${Cartimglst[index]}", price: "${Cartpricelst[index]}", index: index)
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
                              Carttitlelst.removeAt(index);
                              Cartpricelst.removeAt(index);
                              Cartimglst.removeAt(index);
                            });
                            await DataSharedPrefrences.setCartTitle(
                                Carttitlelst);
                            await DataSharedPrefrences.setCartPrice(Cartpricelst);
                            await DataSharedPrefrences.setCartImgUrl(
                                Cartimglst);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
