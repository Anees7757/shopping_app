import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/product_detail.dart';

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);

  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  final List<String> items = [
    'https://laz-img-cdn.alicdn.com/images/ims-web/TB1kBhjyYj1gK0jSZFuXXcrHpXa.jpg_1200x1200q90.jpg_.webp',
    'https://blog.daraz.pk/wp-content/uploads/2020/12/MEGA-DEAL.png',
    'https://www.phoneworld.com.pk/wp-content/uploads/2019/06/Infinix-Hot-6X.jpg',
    'https://blogpakistan.pk/wp-content/uploads/2021/10/daraz-1.jpg',
    'https://topdeals.pk/resize?src=assets/front/media/postimage/2_1622312401Deals_be8d8ebd-4eb7-4449-a35e-3cee71def373-665.jpeg&w=800&h=400',
    'https://www.whatmobile.com.pk/control/news/assets/18062021/63dd62e2a3028311ff97a4c004101358.jpg'
  ];

  List<dynamic> title = [
    'Gaming PC',
    'Iphone 12',
    'Backlit Keyboard',
    'Macbook Air',
    'Macbook Pro',
    'Mercedes',
    'Mutton',
    'Note 20 Ultra',
    'Roadster',
    'Royal Field',
    'Royal Blue Casual Shirt',
    'X80H Series 4K Ultra HD',
  ];

  List<dynamic> price = [
    '111000',
    '250000',
    '20000',
    '300000',
    '460000',
    '5000000',
    '4000000',
    '110000',
    '100000',
    '400000',
    '3000',
    '80000',
  ];

  List<dynamic> imageUrl = [
    'assets/images/gaming_pc.jpg',
    'assets/images/iphone.jpg',
    'assets/images/keyboard.jpg',
    'assets/images/macbook_air.jpg',
    'assets/images/macbook_pro.jpg',
    'assets/images/mercedes.jpg',
    'assets/images/mutton.jpg',
    'assets/images/note20Ultra.jpg',
    'assets/images/roadster.jpg',
    'assets/images/royal_field.jpg',
    'assets/images/shirt.jpg',
    'assets/images/tv.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          CarouselSlider(
              items: items
                  .map((item) => ClipRRect(
                borderRadius: BorderRadius.circular(20),
                    child: Card(
                          child: Image.network(item, fit: BoxFit.cover, width: 1000,)),
                  ),
                      )
                  .toList(),
              options: CarouselOptions(
                height: 135,
                aspectRatio: 16 / 9,
                viewportFraction: 0.95,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 15),
                autoPlayAnimationDuration: const Duration(milliseconds: 1200),
                autoPlayCurve: Curves.easeInOut,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              )),
          SizedBox(
            height: 20
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 4,
                ),
                itemCount: title.length,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductDetail(title:"${title[index]}", img: imageUrl[index], price: price[index], index: index)),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 160,
                            child: Card(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(imageUrl[index],
                                  fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(title[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                                color: Colors.grey
                            )),
                            subtitle: Text("Price: ${price[index]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                              spreadRadius: 0.5,
                              offset: Offset(0,2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                }),
          ),
        ],
    );
  }
}
