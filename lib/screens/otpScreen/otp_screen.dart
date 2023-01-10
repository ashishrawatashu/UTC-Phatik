import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/check_mobile_number_argumnets.dart';
import 'package:utc_flutter_app/screens/otpScreen/otp_screen_provider.dart';
import 'package:utc_flutter_app/utils/all_strings_class.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  late OtpScreenProvider _otpScreenProvider;
  final focus = FocusNode();
  final focusOtp = FocusNode();
  int i = 0;
  var _formKeyForOtpandName = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _otpScreenProvider = Provider.of<OtpScreenProvider>(context, listen: false);
      getDataByGetPhoneNumberScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    // getValueFromArguments();
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Consumer<OtpScreenProvider>(builder: (_, otpScreenProvider, __) {
            return enterVerificationCodeLayout(otpScreenProvider);
          }),
        ));
  }

  enterVerificationCodeLayout(OtpScreenProvider otpScreenProvider) {
    if (otpScreenProvider.isLoading) {
      return Center(
        child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            // Dialog background
            width: 50, // Dialog width
            height: 50, // Dialog height
            child: CircularProgressIndicator(
              color: HexColor(MyColors.primaryColor),
            )),
      );
    } else {
      return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/images/phoneotpbg.png",
                  fit: BoxFit.fill,
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: Image.asset(
                        "assets/images/nicNewLogo.png",
                        height: 50,
                        width: 100,
                      ))),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: EdgeInsets.only(right: 100, bottom: 5),
                      child: Image.asset(
                        "assets/images/utc.png",
                        height: 50,
                        width: 100,
                      ))),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 35, left: 10),
                  child: Column(
                    children: [
                      Align(
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
                                "JKRTC",
                                style: GoogleFonts.oleoScript(
                                  fontSize: 20,
                                  color: HexColor(MyColors.green),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          AllStringsClass.enterVerificationCode,
                          style: GoogleFonts.nunito(
                              fontSize: 30, color: HexColor(MyColors.white)),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: HexColor(MyColors.white),
                              borderRadius:
                              BorderRadius.all(Radius.circular(100))),
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.all(15),
                          height: 120,
                          width: 120,
                          child: Image.asset(
                            "assets/images/otp.png",
                          )),
                      otpNameCardLayout()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  otpNameCardLayout() {
    return Consumer<OtpScreenProvider>(
        builder: (_, otpScreenProvider, __) {
        return Container(
          margin: EdgeInsets.only(left: 10,right: 10,top: 20),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKeyForOtpandName,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        AllStringsClass.enterSixDigitOtp,
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w600,
                            fontSize: 18, color: HexColor(MyColors.primaryColor)),
                      ),
                    ),
                    Text("Mobile Number - +91-"+"XXXXX"+otpScreenProvider.mobilenumber.substring(otpScreenProvider.mobilenumber.length-4,otpScreenProvider.mobilenumber.length),
                      style: GoogleFonts.nunito(fontWeight: FontWeight.w600, fontSize: 18, color: HexColor(MyColors.primaryColor)),),
                    Visibility(
                      visible: otpScreenProvider.already_yn == "Y" ? false : true,
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          focusNode: focus,
                          enableInteractiveSelection: false,
                          autofocus:true,
                          controller: _otpScreenProvider.usernameTextEditingController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: HexColor(MyColors.newGrey),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: HexColor(MyColors.newBorderGrey), width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: HexColor(MyColors.newBorderGrey), width: 2.0),
                            ),
                            hintText: AllStringsClass.fullName,
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: HexColor(MyColors.grey4)),),
                          validator: (value) {
                            otpScreenProvider.userNameValidation(value);
                            return otpScreenProvider.userName;
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        focusNode: focusOtp,
                        maxLength: 6,
                        enableInteractiveSelection: false,
                        autofocus:otpScreenProvider.already_yn == "Y"
                            ? true
                            : false,
                        controller: _otpScreenProvider.otpTextEditingController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: HexColor(MyColors.newGrey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor(MyColors.newBorderGrey), width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor(MyColors.newBorderGrey), width: 2.0),
                          ),
                          hintText: AllStringsClass.otp,
                          hintStyle: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: HexColor(MyColors.grey4)),),
                        validator: (value) {
                          otpScreenProvider.userOtpValidation(value);
                          return otpScreenProvider.otpLength;
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () => otpScreenProvider.userLoginWithOtp(context,_formKeyForOtpandName),
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: HexColor(MyColors.newGreen),
                            borderRadius: BorderRadius.circular(30)),
                        height: 50,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                AllStringsClass.login,
                                style: GoogleFonts.nunito(
                                    color: HexColor(MyColors.white),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive the code? ",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16),
                        ),
                        otpScreenProvider.resendOTP
                            ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(otpScreenProvider.timer),
                            )
                            : TextButton(
                            onPressed: () {
                              i = i + 1;
                              //print(i.toString());
                              // conditions for validating
                              if (i > 3) {
                                otpScreenProvider.text = "Resend";
                                showOtpWarningDialog();
                              } else {
                                otpScreenProvider.getTime(60);
                                _otpScreenProvider.fromResend = true;
                                otpScreenProvider.resendOtp(context);
                              }
                            },
                             child: Text(
                               otpScreenProvider.text,
                              style: TextStyle(
                                  color: HexColor(MyColors.primaryColor),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // void getValueFromArguments() {
  //   var args = ModalRoute.of(context)!.settings.arguments as CheckMobileNumberArguments;
  //   _otpScreenProvider.mobilenumber = args.mobilenumber;
  //   _otpScreenProvider.username = args.username;
  //   _otpScreenProvider.already_yn = args.already_yn;
  //   _otpScreenProvider.EncryptOTP = args.EncryptOTP;
  // }

  showOtpWarningDialog(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
      WillPopScope(
        onWillPop: () async => false,
        child: new AlertDialog(
          title: new Text('Otp limit reached'),
          content: new Text('Please try after some time ! '),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
              child: new Text('Ok'),
            ),
          ],
        ),
      ),
    );
  }

  getDataByGetPhoneNumberScreen() {
    _otpScreenProvider.setLoading(true);
    var args = ModalRoute.of(context)!.settings.arguments as CheckMobileNumberArguments;
    _otpScreenProvider.mobilenumber = args.mobilenumber;
    _otpScreenProvider.username = args.username;
    _otpScreenProvider.already_yn = args.already_yn;
    _otpScreenProvider.EncryptOTP = args.EncryptOTP;
    _otpScreenProvider.setLoading(false);
    print(args.username);
  }


}
