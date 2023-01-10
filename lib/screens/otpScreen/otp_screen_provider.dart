import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:utc_flutter_app/constants/strings.dart';
import 'package:utc_flutter_app/dataSource/checkMobileNumber/check_mobile_number_data_source.dart';
import 'package:utc_flutter_app/dataSource/getTicketsDataSource/get_rating_tickets_data_source.dart';
import 'package:utc_flutter_app/dataSource/loginFail/login_fail_data_source.dart';
import 'package:utc_flutter_app/dataSource/loginFirstTime/login_first_time_data_source.dart';
import 'package:utc_flutter_app/dataSource/loginSuccess/login_success_data_source.dart';
import 'package:utc_flutter_app/response/check_mobile_number_response.dart';
import 'package:utc_flutter_app/response/get_rating_tickets_response.dart';
import 'package:utc_flutter_app/response/login_first_time_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';
import 'package:utc_flutter_app/utils/sharedpref/memory_management.dart';

class OtpScreenProvider extends ChangeNotifier{
  static EncryptedSharedPreferences encryptedSharedPreferences = EncryptedSharedPreferences();
   String mobilenumber = "";
   String username = "";
   String already_yn = "";
   String EncryptOTP = "";
   String MyEncryptOTP = "";
   String login_app_web = "M";
   TextEditingController usernameTextEditingController = TextEditingController();
   TextEditingController otpTextEditingController = TextEditingController();
   String ip_imei = AppConstants.DEVICE_ID!;

  var _otpValidate;
  get otpLength => _otpValidate;
  otpLimitSet(var limit){
    _otpLimit = limit;
    //print(otpLimit);
    notifyListeners();
  }
  void userOtpValidation(String? user) {
    if (user!.length == 6) {
      _otpValidate = null;
    } else {
      _otpValidate = "Invalid otp";

    }
    notifyListeners();
  }

  var _userName;
  get userName => _userName;

  void userNameValidation(String? user) {
    if (user!.length>1) {
       _userName = null;
    } else {
       _userName = "Enter your full name";
    }
    notifyListeners();

  }

  var _otpLimit = 0;
  get otpLimit => _otpLimit;


  bool fromResend = false;

  checkOtpLimit(){
    if(otpLimit<=1){
      return true;
    }else{
      return false;
    }
  }
  saveDataToSharedPref(String isLoggedIn, String isSkipped) async{
    await MemoryManagement.setIsLoggedIn(isLoggedIn: isLoggedIn);
    await MemoryManagement.setUserName(userName: username);
    await MemoryManagement.setIsSkipped(isSkipped: isSkipped);
  }

  matchOtp() async {
    if(EncryptOTP==MyEncryptOTP){
      //print("OTP valid");
      if(already_yn=="N"){
        //print("For N");
        //print(mobilenumber+username);
        await loginFirstTime(mobilenumber, username, login_app_web,ip_imei);
        saveDataToSharedPref("true","false");
      }else {
        //print("For Y");
        //print(mobilenumber+username);
        await loginSuccess(AppConstants.USER_MOBILE_NO, login_app_web, ip_imei);
        saveDataToSharedPref("true","false");
      }
      return true;
    }else{
      await loginFail(mobilenumber, login_app_web, ip_imei);
      return false;
    }

  }

  //first Time user login APi integration

   LoginResponse loginFirstTimeResponse = LoginResponse();
   LoginFirstTimeDataSource loginFirstTimeDataSource = LoginFirstTimeDataSource();

   Future<LoginResponse> loginFirstTime(String mobileNumber,String userName,String login_app_web, String ip_imei) async{
     var response = await loginFirstTimeDataSource.loginFirstTimeApi(mobileNumber,userName,login_app_web,ip_imei);
     //print(response);
     loginFirstTimeResponse = LoginResponse.fromJson(response);
     username = usernameTextEditingController.text.toString();
     return loginFirstTimeResponse;

   }


   // login Success Api integration

   LoginResponse loginSuccessResponse = LoginResponse();
   LoginSuccessDataSource loginSuccessDataSource = LoginSuccessDataSource();

   Future<LoginResponse> loginSuccess(String mobileNumber,String login_app_web, String ip_imei) async{
     var response = await loginSuccessDataSource.loginSuccessApi(mobileNumber,login_app_web,ip_imei);
     //print(response);
     loginSuccessResponse = LoginResponse.fromJson(response);

     if(loginSuccessResponse.code=="100"){
       await MemoryManagement.setPhoneNumber(phoneNumber: loginSuccessResponse.traveller![0].mobilenumber!);
       await MemoryManagement.setUserName(userName: username);
     }

     return loginSuccessResponse;

   }

  //login fail Api integration

  LoginResponse loginFailTimeResponse = LoginResponse();
  LoginFailDataSource loginFailDataSource = LoginFailDataSource();

  Future<LoginResponse> loginFail(String mobileNumber,String login_app_web, String ip_imei) async{
    var response = await loginFailDataSource.loginFailApi(mobileNumber,login_app_web,ip_imei);
    //print(response);
    loginFailTimeResponse = LoginResponse.fromJson(response);
    return loginFailTimeResponse;

  }



  CheckMobileNumberResponse checkMobileNumberResponse = CheckMobileNumberResponse();
  CheckMobileNumberDataSource checkMobileNumberDataSource = CheckMobileNumberDataSource();

  Future<CheckMobileNumberResponse> checkMobileNumber(String mobileNumber, BuildContext context) async{
    var response = await checkMobileNumberDataSource.checkMobileNumberApi(mobileNumber);
    print(response);
    checkMobileNumberResponse = CheckMobileNumberResponse.fromJson(response);
    if(checkMobileNumberResponse.code=="100"){
      Navigator.pop(context);
      already_yn = checkMobileNumberResponse.traveller![0].alreadyYn!;
      EncryptOTP = checkMobileNumberResponse.traveller![0].encryptOTP!;
    }

    // AppConstants.USER_MOBILE_NO = checkMobileNumberResponse.traveller![0].mobilenumber!;

    return checkMobileNumberResponse;


  }


//check rating

  GetRatingTicketsResponse getRatingTicketsResponse = GetRatingTicketsResponse();
  GetRatingTicketsDataSource getRatingTicketsDataSource = GetRatingTicketsDataSource();
  List<Ticket> getRatingTicketsList = [];


  Future<GetRatingTicketsResponse> getRatingTickets() async {
    var response = await getRatingTicketsDataSource.getTicketsApi(AppConstants.USER_MOBILE_NO,AppConstants.MY_TOKEN);
    //print(response);
    getRatingTicketsResponse = GetRatingTicketsResponse.fromJson(response);
    if(getRatingTicketsResponse.code=="100"){
      getRatingTicketsList = getRatingTicketsResponse.ticket!;
    }
    return getRatingTicketsResponse;
  }


  userLoginWithOtp(BuildContext context, GlobalKey<FormState> formKeyForOtpandName) async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
      if (formKeyForOtpandName.currentState!.validate()) {
        // username = usernameTextEditingController.text.toString();
        //print(username);

        //encrypt user OTP

        //sha 512 convert...
        var bytes = utf8.encode(otpTextEditingController.text.toString());
        var digest = sha512.convert(bytes);
        MyEncryptOTP = digest.toString().toUpperCase();

        CommonMethods.showLoadingDialog(context);
        if (await matchOtp() == true) {
          // await _otpScreenProvider.getRatingTickets();
          Navigator.pop(context);
          await MemoryManagement.setPhoneNumber(phoneNumber: mobilenumber);
          DateTime loginDateTime = DateTime.now();
          //print(loginDateTime.toString());
          await MemoryManagement.setLoginDateTime(dateTime: loginDateTime.toString());
          moveToHomeScreen(context);
          otpTextEditingController.text = "";
          // _otpScreenProvider.usernameTextEditingController.text = "";
          CommonMethods.showSnackBar(context, "Login successfully");
          // if (getRatingTicketsList.isEmpty) {
          //
          // } else {
          //   moveToRatingListScreen(context);
          // }
        } else {
          Navigator.pop(context);
          CommonMethods.showSnackBar(context, "Invalid OTP !");
        }
      }
    } else {
      CommonMethods.showNoInternetDialog(context);
    }
  }

  bool resendOTP = false;
  String timer = "60";
  String text = "Resend";

  resendOtp(BuildContext context) async {
      resendOTP = true;
    if (checkOtpLimit()) {
      if (await CommonMethods.getInternetUsingInternetConnectivity()) {
        CommonMethods.showLoadingDialog(context);
        //print(mobilenumber+"aaaaaaa");
        await checkMobileNumber(mobilenumber,context);
        CommonMethods.showSnackBar(context, "OTP sent successfully");
        Navigator.pop(context);
        otpLimitSet(otpLimit + 1);
      } else {
        CommonMethods.showNoInternetDialog(context);
      }
    } else {
      // showOtpWarningDialog();
        text = "Resend";
      // CommonMethods.showSnackBar(context, "Please try after some time !");
    }

    notifyListeners();
  }

  getTime(int i) {
    Timer.periodic(Duration(seconds: 1), (t) {
      if (i == 1) {
        t.cancel();
          resendOTP = false;
        notifyListeners();
      }
      //print(i.toString());
      i = i - 1;
      timer = i.toString() + " sec";
       notifyListeners();
    });

  }

  bool _isLoading = true;
  get isLoading => _isLoading;

  setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  moveToHomeScreen(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pushNamed(context, MyRoutes.homeRoute);
  }

  moveToRatingListScreen(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pushNamed(context, MyRoutes.rateScreenList);
  }

}