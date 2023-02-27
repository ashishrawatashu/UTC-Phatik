import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

import 'my_routes.dart';

class CommonMethods {

  static Future<bool> getInternetUsingInternetConnectivity() async {

    bool result = await InternetConnectionChecker().hasConnection;
    //print("CHECK----"+result.toString());
    return result;

    // try {
    //   final result = await InternetAddress.lookup('google.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //       //print("Connected ");
    //       return true;
    //   }else {
    //     //print("Not connected ");
    //     return false;
    //   }
    // } on SocketException catch (_) {
    //     return false;
    // }

  }

  static showLoadingDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  // Dialog background
                  width: 50, // Dialog width
                  height: 50, // Dialog height
                  child: CircularProgressIndicator(
                    color: HexColor(MyColors.primaryColor),
                  )),
            ),
          ),
        );
      },
    );
  }

  static showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("No internet"),
        content: Text("Please connet your device with internet"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  static showSnackBar(BuildContext context, String msg) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                  shape: RoundedRectangleBorder(borderRadius:
                  BorderRadius.circular(20.0)), //this right here
                  child: Wrap(
                    children: [
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.asset("assets/images/warning.png",
                                    width: 80, height: 80, fit: BoxFit.fill,),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Center(child: Padding(
                                padding: const EdgeInsets.only(left: 15.0,right: 15),
                                child: Text(msg,
                                  textAlign: TextAlign.center, style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w600),),
                              )),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom: 10, left: 20, right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: HexColor(MyColors.primaryColor),
                              ),
                              height: 40,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text("OK",
                                        style: TextStyle(color: Colors.white)),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
              ),
            );
          });
    }


  static dialogDone(BuildContext context, String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
                shape: RoundedRectangleBorder(borderRadius:
                BorderRadius.circular(20.0)), //this right here
                child: Wrap(
                  children: [
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset("assets/images/check.png",
                                  width: 80, height: 80, fit: BoxFit.fill,),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Center(child: Padding(
                              padding: const EdgeInsets.only(left: 15.0,right: 15),
                              child: Text(msg,
                                textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),),
                            )),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: 10, left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: HexColor(MyColors.primaryColor),
                            ),
                            height: 40,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Text("OK",
                                      style: TextStyle(color: Colors.white)),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ),
          );
        });
  }

  static feedBackDiaog(BuildContext context, String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
                shape: RoundedRectangleBorder(borderRadius:
                BorderRadius.circular(20.0)), //this right here
                child: Wrap(
                  children: [
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset("assets/images/check.png",
                                  width: 80, height: 80, fit: BoxFit.fill,),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Center(child: Padding(
                              padding: const EdgeInsets.only(left: 15.0,right: 15),
                              child: Text(msg,
                                textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),),
                            )),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, MyRoutes.rateScreenList);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: 10, left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: HexColor(MyColors.primaryColor),
                            ),
                            height: 40,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Text("OK",
                                      style: TextStyle(color: Colors.white)),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ),
          );
        });
  }


  static noDataFound(BuildContext context){
    return Center(
      child: Container(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/empty.png",width: 200,height: 100,),
            Text("Sorry, No data is available", style: GoogleFonts.nunito(
                fontSize: 16,fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }

  static noBusFound(BuildContext context){
    return Center(
      child: Container(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/empty.png",width: 200,height: 100,),
            Text("Sorry, No bus is available ", style: GoogleFonts.nunito(
                fontSize: 16,fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }

  static noActiveBookings(BuildContext context){
    return Center(
      child: Container(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/empty.png",width: 200,height: 100,),
            Text("Sorry, No active booking", style: GoogleFonts.nunito(
                fontSize: 16,fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }

  static noOffer(BuildContext context){
    return Center(
      child: Container(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/empty.png",width: 200,height: 100,),
            Text("Sorry, No offer is available", style: GoogleFonts.nunito(
                fontSize: 16,fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }


  static noDataState(BuildContext context, String error){
    return Center(
      child: Container(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/empty.png",width: 200,height: 100,),
            Text(error, style: GoogleFonts.nunito(
                fontSize: 16,fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }


  static doneState(BuildContext context, String msg){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius:
              BorderRadius.circular(20.0)), //this right here
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 215,
                // color: HexColor(MyColors.dashBg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/images/successcheck.png",width: 80,height: 80,fit: BoxFit.fill,),
                      ),
                    ),
                    Center(child: Padding(
                      padding: const EdgeInsets.only(left: 5.0,right: 5),
                      child: Text(msg,textAlign:TextAlign.center,style: GoogleFonts.nunito(fontSize: 14,fontWeight: FontWeight.w600),),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor(MyColors.orange),
                        ),
                        height: 35,
                        width:MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text("OK",style: GoogleFonts.nunito(color: Colors.white)),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });

  }


  static showTokenExpireDialog(BuildContext context){

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius:
              BorderRadius.circular(20.0)), //this right here
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                // color: HexColor(MyColors.dashBg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/images/expired.png",width: 80,height: 80,fit: BoxFit.fill,),
                      ),
                    ),
                    Center(child: Padding(
                      padding: const EdgeInsets.only(left: 5.0,right: 5),
                      child: Text("Your token is expired, please try again",textAlign:TextAlign.center,style: GoogleFonts.nunito(fontSize: 15,fontWeight: FontWeight.bold),),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                       Navigator.pushNamed(context, MyRoutes.homeRoute);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor(MyColors.orange),
                        ),
                        height: 40,
                        width:MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text("OK",style: GoogleFonts.nunito(color: Colors.white)),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });

  }

  static showErrorDialog(BuildContext context,String msg){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius:
              BorderRadius.circular(20.0)), //this right here
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                // color: HexColor(MyColors.dashBg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/images/oops.png",width: 80,height: 80,fit: BoxFit.fill,),
                      ),
                    ),
                    Center(child: Padding(
                      padding: const EdgeInsets.only(left: 5.0,right: 5),
                      child: Text(msg,textAlign:TextAlign.center,style: GoogleFonts.nunito(fontSize: 14,fontWeight: FontWeight.bold),),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                       // Navigator.pushNamed(context, MyRoutes.homeRoute);
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else if (Platform.isIOS) {
                          exit(0);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor(MyColors.orange),
                        ),
                        height: 40,
                        width:MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text("OK",style: GoogleFonts.nunito(color: Colors.white)),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });

  }


  static updateApp(BuildContext context,String msg){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius:
              BorderRadius.circular(20.0)), //this right here
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                // color: HexColor(MyColors.dashBg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/images/utcroundlogo.png",width: 80,height: 80,fit: BoxFit.fill,),
                      ),
                    ),
                    Center(child: Padding(
                      padding: const EdgeInsets.only(left: 5.0,right: 5),
                      child: Text(msg,textAlign:TextAlign.center,style: GoogleFonts.nunito(fontSize: 14,fontWeight: FontWeight.bold),),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, MyRoutes.homeRoute);
                        if (Platform.isAndroid) {
                          // SystemNavigator.pop();
                        } else if (Platform.isIOS) {
                          // exit(0);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor(MyColors.orange),
                        ),
                        height: 40,
                        width:MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text("Update",style: GoogleFonts.nunito(color: Colors.white)),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });

  }

  static showIsAppNotActive(BuildContext context,String phoneNumber, String email){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius:
              BorderRadius.circular(20.0)), //this right here
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 320,
                // color: HexColor(MyColors.dashBg),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset("assets/images/oops.png",width: 80,height: 80,fit: BoxFit.fill,),
                          ),
                        ),
                        Center(child: Text("App is under maintenance",textAlign:TextAlign.center,style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.w600),)),
                        Center(child: Text("App is undergoing scheduled maintenance.  ",textAlign:TextAlign.center,style: GoogleFonts.nunito(fontSize: 12,fontWeight: FontWeight.w500,color: HexColor(MyColors.grey1)),)),
                        Center(child: Text("We should be back shortly.\nThank you for the patience ",textAlign:TextAlign.center,style: GoogleFonts.nunito(fontSize: 12,fontWeight: FontWeight.w500,color: HexColor(MyColors.grey1)),)),
                        Center(
                          child: Padding(padding: const EdgeInsets.only(top: 10),
                            child: Text("For any query please contact our help desk",textAlign:TextAlign.center,style: GoogleFonts.nunito(fontSize: 14,fontWeight: FontWeight.w600),),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 8,right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.phone,color: HexColor(MyColors.primaryColor),size: 20,),
                                SizedBox(width: 10,),
                                InkWell(
                                  onTap: ()async {
                                    String urlName = "tel:"+phoneNumber;
                                    var url = urlName.toString();
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Text(phoneNumber,textAlign:TextAlign.center,style: GoogleFonts.nunito(
                                      decoration: TextDecoration.underline,
                                      color: HexColor(MyColors.primaryColor),
                                      fontSize: 15,fontWeight: FontWeight.w600),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.email,color: HexColor(MyColors.primaryColor),size: 20,),
                                SizedBox(width: 10,),
                                Text(email,textAlign:TextAlign.center,style: GoogleFonts.nunito(
                                    color: HexColor(MyColors.black),
                                    fontSize: 15,fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, MyRoutes.homeRoute);
                          if (Platform.isAndroid) {
                            SystemNavigator.pop();
                          } else if (Platform.isIOS) {
                            exit(0);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10,left: 20,right: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: HexColor(MyColors.orange),
                          ),
                          height: 40,
                          width:MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Text("OK",style: GoogleFonts.nunito(color: Colors.white)),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ),
          );
        });

  }

  static appIsNotWorking(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  // color: HexColor(MyColors.dashBg),
                  child: Wrap(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset("assets/images/utc.png",width: 100,height: 100,fit: BoxFit.fill,),
                            ),
                          ),
                          Center(child: Text("We'll be back soon",textAlign:TextAlign.center,style: GoogleFonts.nunito(fontSize: 22,fontWeight: FontWeight.w600),)),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(left: 20,top: 8,right: 20),
                              child: Text("Thank you for being our valued customer. Our services will be available soon",textAlign:TextAlign.justify,style: GoogleFonts.nunito(fontSize: 18,fontWeight: FontWeight.w600,color: HexColor(MyColors.grey6)),),
                            ),
                          ),
                          SizedBox(height: 10,)
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context, MyRoutes.homeRoute);
                            if (Platform.isAndroid) {
                              SystemNavigator.pop();
                            } else if (Platform.isIOS) {
                              exit(0);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10,left: 20,right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: HexColor(MyColors.orange),
                            ),
                            height: 40,
                            width:MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Text("Exit",style: GoogleFonts.nunito(color: Colors.white)),),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
              ),
            ),
          );
        });

  }

  static showErrorMoveToDashBaordDialog(BuildContext context,String msg){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius:
              BorderRadius.circular(20.0)), //this right here
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                // color: HexColor(MyColors.dashBg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/images/oops.png",width: 80,height: 80,fit: BoxFit.fill,),
                      ),
                    ),
                    Center(child: Padding(
                      padding: const EdgeInsets.only(left: 5.0,right: 5),
                      child: Text(msg,textAlign:TextAlign.center,style: GoogleFonts.nunito(fontSize: 14,fontWeight: FontWeight.bold),),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, MyRoutes.homeRoute);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor(MyColors.orange),
                        ),
                        height: 40,
                        width:MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text("OK",style: GoogleFonts.nunito(color: Colors.white)),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });

  }

}
