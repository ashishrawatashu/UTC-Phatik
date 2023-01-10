import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

class IntroScreen extends StatefulWidget{

  const IntroScreen({Key? key}) : super(key: key);
  @override

  IntroScreenState createState() => IntroScreenState();

}

class IntroScreenState extends State<IntroScreen>{

  final List<String> imgList = [

    // 'assets/images/bus1.jpeg',
    // 'assets/images/bus1.jpeg',
    // 'assets/images/bus1.jpeg',
    // 'assets/images/bus1.jpeg',

    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'





  ];

  @override
  Widget build(BuildContext context) {
    BoxShadow boxShadow = BoxShadow(
      color: Colors.grey[350]!,
      blurRadius: 5.0,
    );
    return Scaffold(
      body: Stack(
        children: [
          Builder(
            builder: (context) {
              final double height = MediaQuery.of(context).size.height;
              return CarouselSlider(
                options: CarouselOptions(
                  height: height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                ),
                items: imgList.map((item) => Container(
                  child: Center(
                      child: Image.network(
                        item,
                        fit: BoxFit.cover,
                        height: height,
                      )),
                ))
                    .toList(),
              );
            },
          ),
          InkWell(
            onTap: (){moveToHome(context);

            },
            child: Padding(padding: EdgeInsets.only(right: 20,top: 60),child: Align(
              alignment: Alignment.topRight,
              child: Text("Skip",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25
                ),),
            ),),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Spacer(),
                Material(
                  borderRadius: BorderRadius.circular(12),
                  color: HexColor(MyColors.primaryColor),
                  child: InkWell(
                    onTap: () => moveToGetPhoneNumber(context),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      width: MediaQuery.of(context).size.width*0.9,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),

              ],
            ),
          )
        ],
      ),
    );

  }

  moveToHome(BuildContext context) {
    Navigator.pushNamed(context, MyRoutes.homeRoute);
  }

  moveToGetPhoneNumber(BuildContext context) {
    Navigator.pushNamed(context, MyRoutes.getPhoneNumberScreen);

  }
}

