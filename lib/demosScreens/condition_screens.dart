import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

class ConditionsScreens extends StatelessWidget {

  ConditionsScreens({Key? key}) : super(key: key);
  Map<String,dynamic> mapData = Map();


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      padding: EdgeInsets.only(top: 100),
      color: Colors.white,
      child: Column(
        children: [

          // ElevatedButton(onPressed: (){}, child: Text("If user SKIP the Login",textAlign: TextAlign.center,)),
          ElevatedButton(
              onPressed: (){
                mapData = {
              '"recent"' : false,
              '"offers"': false,
              '"popularsRoutes"': false,
            };
            Navigator.pushNamed(context, MyRoutes.homeScreen2,arguments: mapData);


           }, child: Text("No recent,offers,populars routes",textAlign: TextAlign.center,)),
          ElevatedButton(onPressed: (){
            mapData = {
              '"recent"' : true,
              '"offers"': true,
              '"popularsRoutes"': true,
            };


            Navigator.pushNamed(context, MyRoutes.homeScreen2,arguments: mapData);
          }, child: Text("Have recent,offers,populars routes",textAlign: TextAlign.center,)),
          ElevatedButton(onPressed: (){
            mapData = {
              '"recent"' : false,
              '"offers"': true,
              '"popularsRoutes"': true,
            };


            Navigator.pushNamed(context, MyRoutes.homeScreen2,arguments: mapData);
          }, child: Text("Popular+Offers",textAlign: TextAlign.center,)),
          ElevatedButton(onPressed: (){
            mapData = {
              '"recent"' : true,
              '"offers"': false,
              '"popularsRoutes"': true,
            };


            Navigator.pushNamed(context, MyRoutes.homeScreen2,arguments: mapData);
          }, child: Text("recent + polulars",textAlign: TextAlign.center,)),
          ElevatedButton(onPressed: (){
            mapData = {
              '"recent"' : true,
              '"offers"': true,
              '"popularsRoutes"': false,
            };


            Navigator.pushNamed(context, MyRoutes.homeScreen2,arguments: mapData);
          }, child: Text("recent + offers",textAlign: TextAlign.center,)),
          ElevatedButton(onPressed: (){
            mapData = {
              '"recent"' : true,
              '"offers"': false,
              '"popularsRoutes"': false,
            };


            Navigator.pushNamed(context, MyRoutes.homeScreen2,arguments: mapData);
          }, child: Text("Have recent",textAlign: TextAlign.center,)),
          ElevatedButton(onPressed: (){
            mapData = {
              '"recent"' : false,
              '"offers"': false,
              '"popularsRoutes"': true,
            };


            Navigator.pushNamed(context, MyRoutes.homeScreen2,arguments: mapData);
          }, child: Text("Have polulars routes",textAlign: TextAlign.center,)),
          ElevatedButton(onPressed: (){
            mapData = {
              '"recent"' : false,
              '"offers"': true,
              '"popularsRoutes"': false,
            };
            Navigator.pushNamed(context, MyRoutes.homeScreen2,arguments: mapData);
          }, child: Text("Have offers",textAlign: TextAlign.center,)),

        ],
      ),
    ));
  }
}
