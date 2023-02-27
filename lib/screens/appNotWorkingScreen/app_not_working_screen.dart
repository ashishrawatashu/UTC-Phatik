import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class AppNotWorkingScreen extends StatefulWidget {
  const AppNotWorkingScreen({Key? key}) : super(key: key);

  @override
  State<AppNotWorkingScreen> createState() => _AppNotWorkingScreenState();

}

class _AppNotWorkingScreenState extends State<AppNotWorkingScreen> {
  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() async {
      return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit the app ? '),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
            TextButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
              child: new Text('Yes'),
            ),
          ],
        ),
      )) ??
          false;
    }
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: HexColor(MyColors.primaryColor),
          title: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Text(
                  "StarBus*",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  color: HexColor(MyColors.white),
                  margin: EdgeInsets.only(left: 4, right: 1),
                  width: 1,
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 5),
                  child: Text(
                    "UTC Pathik",
                    style: GoogleFonts.oleoScript(
                      fontSize: 20,
                      color: HexColor(MyColors.green),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top:120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset("assets/images/utc.png",width: 150,height: 150,fit: BoxFit.fill,),
                  ),
                ),
                Center(child: Text("We'll be back soon",textAlign:TextAlign.center,style: GoogleFonts.nunito(fontSize: 25,fontWeight: FontWeight.w600),)),
                // Container(
                //   margin: EdgeInsets.only(left: 20,top: 8,right: 10),
                //   child: Text("Sorry for the inconvenience but we're performing some maintenance at the moment.We'll be back online shortly !",textAlign:TextAlign.left,style: GoogleFonts.nunito(fontSize: 16,fontWeight: FontWeight.w600,color: HexColor(MyColors.grey6)),),
                // ),
                Container(
                  margin: EdgeInsets.only(left: 20,top: 8,right: 10),
                  child: Text("Thank you for serving us, our services will be started soon.",textAlign:TextAlign.left,style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.w600,color: HexColor(MyColors.grey6)),),
                ),
                // Container(
                //   margin: EdgeInsets.only(left: 20,top: 8,right: 10),
                //   child: Center(child: Text("Thanks for the patience !",textAlign:TextAlign.left,style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.w700,color: HexColor(MyColors.grey6)),)),
                // ),
              ],
            )
        ),
      ),
    );
  }
}
