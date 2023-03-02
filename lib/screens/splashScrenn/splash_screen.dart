import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/screens/splashScrenn/splash_screen_provider.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  late SplashScreenProvider _splashScreenProvider;

  @override
  void initState() {
    super.initState();
    _splashScreenProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    _splashScreenProvider.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SplashScreenProvider>(
        builder: (_,splashScreenProvider,__){
          return splashBody();
        },
      ),
    );
  }


  Widget splashBody(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: HexColor(MyColors.green),
        child: Center(
          child: Stack(
            children: [
              Positioned.fill(
                  child: Container(
                    color: HexColor(MyColors.primaryColor),
                    child: Image.asset("assets/images/bgthree.png",fit: BoxFit.fill,),
                  )),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 150),
                  child: Column(
                    children: [
                      Text("StarBus*",style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
                      Text("UTC Pathik",style: GoogleFonts.oleoScript(fontSize: 40,color: Colors.white),),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Image.asset("assets/images/utcroundlogo.png",height: 150,width: 150),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Image.asset("assets/images/utcname.png",height: 30,width: 200,fit: BoxFit.fill,),
                      ),

                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Visibility(
                  visible: false,
                  child: Container(
                      child: Card(child: Image.asset("assets/images/govsLogos.png",height: 45,width: 120,fit: BoxFit.fill,))),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    child: Image.asset("assets/images/nicNewLogo.png",height: 45,width: 120,fit: BoxFit.fill,)),
              )
            ],
          ),
        ));
  }

}
