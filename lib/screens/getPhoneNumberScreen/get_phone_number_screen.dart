import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/screens/getPhoneNumberScreen/get_phone_number_provider.dart';
import 'package:utc_flutter_app/utils/all_strings_class.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

class GetPhoneNumberScreen extends StatefulWidget {
  GetPhoneNumberScreen({Key? key}) : super(key: key);
  @override
  _GetPhoneNumberScreenState createState() => _GetPhoneNumberScreenState();
}

class _GetPhoneNumberScreenState extends State<GetPhoneNumberScreen> {

  late GetPhoneNumberProvider _getPhoneNumberProvider;
  final focus = FocusNode();
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _getPhoneNumberProvider = Provider.of<GetPhoneNumberProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: otpVerificationLayout(),
      ),
    );
  }

  otpVerificationLayout() {
    return SingleChildScrollView(
      child: SizedBox(
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
                    padding: EdgeInsets.only(right: 100,bottom: 5),
                    child: Image.asset(
                      "assets/images/utc.png",
                      height: 50,
                      width: 100,
                    ))),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 35),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(3),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Text("StarBus*",
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
                      Visibility(
                        visible: true,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                              onTap: () {
                                _getPhoneNumberProvider.userSkipLogin();
                                moveToDashBoard(context);
                              },
                              child: Container(margin: EdgeInsets.only(right: 20), child: Text("Skip",
                                    style: GoogleFonts.nunito(
                                        color: Colors.white, fontSize: 22),
                                  ))),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          AllStringsClass.otpVerification,
                          style: GoogleFonts.nunito(
                              fontSize: 20, color: HexColor(MyColors.white)),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: HexColor(MyColors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.all(15),
                          height: 120,
                          width: 120,
                          child: Image.asset(
                            "assets/images/phone.png",
                            fit: BoxFit.contain,
                          )),
                      mobileNumberCardLayout(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  moveToDashBoard(BuildContext context) {
    Navigator.pushNamed(context, MyRoutes.homeRoute);
  }

  //card Layout
  mobileNumberCardLayout() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                child: Text(
                  AllStringsClass.loginWithMobileNo,
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: HexColor(MyColors.primaryColor)),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 5),
              //   child: Text(
              //     AllStringsClass.enterNumber,
              //     style: GoogleFonts.nunito(
              //         fontSize: 14, color: HexColor(MyColors.primaryColor)),
              //   ),
              // ),
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    focusNode: focus,
                    autofocus: true,

                    enableInteractiveSelection: false,
                    cursorColor: HexColor(MyColors.primaryColor),
                    controller: _getPhoneNumberProvider.phoneNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    // controller: fillPassengerDetailsProvider.userOtpTextEditingController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor(MyColors.newGrey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: HexColor(MyColors.newBorderGrey),
                            width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: HexColor(MyColors.newBorderGrey),
                            width: 2.0),
                      ),
                      hintText: AllStringsClass.mobileNumber,
                      prefixText: '+91 - ',
                      hintStyle: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: HexColor(MyColors.grey4)),
                    ),
                    validator: (value) {
                      _getPhoneNumberProvider.uservalidation(value);
                      return _getPhoneNumberProvider.userPhoneNumber;
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _getPhoneNumberProvider.getOtp(context,_formKey);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15,bottom: 10),
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
                          AllStringsClass.getOtp,
                          style: GoogleFonts.roboto(
                              color: HexColor(MyColors.white),
                              fontWeight: FontWeight.w600,
                              fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
