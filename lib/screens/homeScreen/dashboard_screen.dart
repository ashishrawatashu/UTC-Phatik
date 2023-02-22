import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/common_provider_for_in_app_login.dart';
import 'package:utc_flutter_app/screens/bottomTabsScreens/accountTab/my_account_tab.dart';
import 'package:utc_flutter_app/screens/bottomTabsScreens/homeTab/home_tab.dart';
import 'package:utc_flutter_app/screens/bottomTabsScreens/myBookingTab/my_history_tab.dart';
import 'package:utc_flutter_app/screens/bottomTabsScreens/walletTab/wallet_tab.dart';
import 'package:utc_flutter_app/screens/homeScreen/dashboard_screen_provider.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';
import 'package:utc_flutter_app/utils/sharedpref/memory_management.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {

  late DashBoardScreenProvider _dashBoardScreenProvider;
  TextEditingController _phoneNumberController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _formKeyForLoginDialog = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _dashBoardScreenProvider = Provider.of<DashBoardScreenProvider>(context, listen: false);
    _dashBoardScreenProvider.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // showDialogBox();
    Future<bool> onWillPop() async {
      if(AppConstants.index==0){
        return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want exit from app ? '),
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
        ));
      }else {
        AppConstants.index = 0;
        Navigator.pushNamed(context, MyRoutes.homeRoute);
        return false;
      }
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        // endDrawerEnableOpenDragGesture: true,
        // endDrawer: NavigationDrawer(),
        // backgroundColor: HexColor(MyColors.primaryColor),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: HexColor(MyColors.primaryColor),
          backgroundColor: Colors.white,
          selectedLabelStyle: TextStyle(color: HexColor(MyColors.primaryColor)),
          unselectedItemColor: Colors.blueGrey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: AppConstants.index,
          unselectedFontSize: 10,
          selectedFontSize: 12,
          onTap: (int index) async {
            setState(() {
             chekUserLoginOrNot(index);
            });
            // _navigateToScreens(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              backgroundColor: Colors.white,
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              backgroundColor: Colors.white,
              label: "My History",
            ),
            BottomNavigationBarItem(
                icon: AppConstants.index == 2
                    ? Image.asset(
                        'assets/images/walletblue.png',
                        height: 25,
                        width: 30,
                      )
                    : Image.asset(
                        'assets/images/walletgrey.png',
                        height: 25,
                        width: 30,
                      ),
                backgroundColor: Colors.white,
                label: "Wallet"),
            BottomNavigationBarItem(
                icon: Icon(Icons.discount),
                backgroundColor: Colors.white,
                label: "Offers")
          ],
        ),
        body: showScreens(AppConstants.index),
      ),
    );

  }

  showScreens(int index) {
    switch (index) {
      case 0:
        return HomeTab();
      case 1:
        return MyHistoryTab();
      case 2:
        return WalletTab();
      case 3:
        return MyAccountTab();
    }
  }

  void showDialogBox() {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Container(
          height: MediaQuery.of(context).size.height * 9,
          width: MediaQuery.of(context).size.width * 9,
        ),
      ),
    );
  }


  chekUserLoginOrNot(int index) async {
    await _dashBoardScreenProvider.getUserData();
    if(index==1||index==2){
      if (_dashBoardScreenProvider.isUserLoggedIn == "false" || _dashBoardScreenProvider.isUserSkipped == "true") {
        showMobileNumberBottomSheet(index);
      }
      else {
        AppConstants.index = index;
      }
    }else {
      AppConstants.index = index;
    }
  }




  showMobileNumberBottomSheet(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (BuildContext context) {
        return Consumer<CommonProviderForInAppLogin>(
          builder: (_, commonProviderForInAppLogin, __) {
            return Container(
              padding: MediaQuery.of(context).viewInsets,
              margin: EdgeInsets.only(top: 20, bottom: 30, left: 30, right: 30),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: HexColor(MyColors.black)),
                      ),
                      Text(
                        "Enter your number we will sent otp to verify",
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: HexColor(MyColors.grey6)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, right: 20),
                        child: TextFormField(
                          enableInteractiveSelection: false,
                          controller: commonProviderForInAppLogin.userPhoneTextEditingController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Image.asset(
                                    "assets/images/phoneicon.png",
                                    height: 10,
                                    width: 10,
                                  )),
                              hintText: "Enter number",
                              hintStyle: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor(MyColors.grey4)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor(MyColors.primaryColor)))),
                          validator: (value) {
                            commonProviderForInAppLogin.uservalidation(value);
                            return commonProviderForInAppLogin.userPhoneNumber;
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () => getOtp(commonProviderForInAppLogin,index),
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: HexColor(MyColors.orange),
                              // boxShadow: [
                              //   BoxShadow(
                              //     // color: Colors.grey,
                              //     offset: Offset(0.0, 1.0), //(x,y)
                              //     blurRadius: 0.1,
                              //   ),
                              // ],
                              borderRadius: BorderRadius.circular(30)),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 45,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "GET OTP",
                                  style: GoogleFonts.roboto(
                                      color: HexColor(MyColors.white),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
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
          },
        );
      },
    );
  }

  showLoginBottomSheet(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (BuildContext context) {
        return Consumer<CommonProviderForInAppLogin>(
          builder: (_, commonProviderForInAppLogin, __) {
            commonProviderForInAppLogin.userOtpTextEditingController.clear();
            return Container(
              padding: MediaQuery.of(context).viewInsets,
              margin: EdgeInsets.only(top: 20, bottom: 30, left: 30, right: 30),
              child: Form(
                key: _formKeyForLoginDialog,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Enter the 6 Digit OTP recieved on your",
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: HexColor(MyColors.grey6)),
                      ),
                      Text(
                        "Mobile Number - +91-"+"XXXXX"+commonProviderForInAppLogin.mobilenumber.substring(commonProviderForInAppLogin.mobilenumber.length-4,commonProviderForInAppLogin.mobilenumber.length),
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: HexColor(MyColors.grey6)),
                      ),
                      Visibility(
                        visible: commonProviderForInAppLogin.already_yn == "Y"
                            ? false
                            : true,
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: TextFormField(
                            enableInteractiveSelection: false,
                            controller: commonProviderForInAppLogin
                                .userFullNameTextEditingController,
                            maxLength: 10,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[A-Z a-z]')),
                            ],
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Image.asset(
                                      "assets/images/usernameicon.png",
                                      height: 10,
                                      width: 10,
                                    )),
                                hintText: "Full Name",
                                hintStyle: GoogleFonts.nunito(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: HexColor(MyColors.grey4)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            HexColor(MyColors.primaryColor)))),
                            validator: (value) {
                              commonProviderForInAppLogin
                                  .userNameValidation(value);
                              return commonProviderForInAppLogin.userName;
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          enableInteractiveSelection: false,
                          controller: commonProviderForInAppLogin
                              .userOtpTextEditingController,
                          maxLength: 6,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Image.asset(
                                    "assets/images/lockicon.png",
                                    height: 10,
                                    width: 10,
                                  )),
                              hintText: "OTP",
                              hintStyle: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor(MyColors.grey4)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor(MyColors.primaryColor)))),
                          validator: (value) {
                            commonProviderForInAppLogin
                                .userOtpValidation(value);
                            return commonProviderForInAppLogin.otpLength;
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () => userLoginWithOtp(commonProviderForInAppLogin,index),
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: HexColor(MyColors.orange),
                              // boxShadow: [
                              //   BoxShadow(
                              //     // color: Colors.grey,
                              //     offset: Offset(0.0, 1.0), //(x,y)
                              //     blurRadius: 0.1,
                              //   ),
                              // ],
                              borderRadius: BorderRadius.circular(30)),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "SUBMIT",
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
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didnt get the OTP? ",
                              style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: HexColor(MyColors.grey6)),
                            ),
                            Text(
                              "Resend",
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: HexColor(MyColors.primaryColor)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  getOtp(CommonProviderForInAppLogin commonProviderForInAppLogin, int index) async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
      if (_formKey.currentState!.validate()) {
        CommonMethods.showLoadingDialog(context);
        commonProviderForInAppLogin.mobilenumber = commonProviderForInAppLogin.userPhoneTextEditingController.text;
        await commonProviderForInAppLogin.checkMobileNumber(commonProviderForInAppLogin.userPhoneTextEditingController.text);
        commonProviderForInAppLogin.otpLimitSet(commonProviderForInAppLogin.otpLimit + 1);
        Navigator.pop(context);
        Navigator.pop(context);
        showLoginBottomSheet(index);
      }
    } else {
      CommonMethods.showNoInternetDialog(context);
    }
  }


  userLoginWithOtp(CommonProviderForInAppLogin commonProviderForInAppLogin, int index) async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
      if (_formKeyForLoginDialog.currentState!.validate()) {
        var bytes = utf8.encode(commonProviderForInAppLogin.userOtpTextEditingController.text.toString());
        var digest = sha512.convert(bytes);
        commonProviderForInAppLogin.MyEncryptOTP = digest.toString().toUpperCase();
        CommonMethods.showLoadingDialog(context);
        if (await commonProviderForInAppLogin.matchOtp() == true) {
          await MemoryManagement.setIsLoggedIn(isLoggedIn: "true");
          await MemoryManagement.setIsSkipped(isSkipped: "false");
          // await MemoryManagement.setUserName(userName: "Ashish");
          Navigator.pop(context);
          Navigator.pop(context);
          await commonProviderForInAppLogin.getPhoneNumber();
          CommonMethods.dialogDone(context, "Login successfully");
          setState(() {
            AppConstants.index = index;
          });
        } else {
          Navigator.pop(context);
          CommonMethods.showSnackBar(context, "Invalid OTP !");
        }
      }
    } else {
      CommonMethods.showNoInternetDialog(context);
    }
  }
}
