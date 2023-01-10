import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:utc_flutter_app/arguments/check_mobile_number_argumnets.dart';
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

class GetPhoneNumberProvider extends ChangeNotifier{

  var _otpLimit = 0;
  get otpLimit => _otpLimit;
  TextEditingController phoneNumberController = TextEditingController();
  bool fromResend = false;



  otpLimitSet(var limit){
    _otpLimit = limit;
    //print(otpLimit);
    notifyListeners();
  }


  checkOtpLimit(){
    if(otpLimit<=3){
      return true;
    }else{
      return false;
    }
  }


  //phone Number Validate

  var _userPhoneNumber;

  get userPhoneNumber => _userPhoneNumber;

  void uservalidation(String? user) {
    if (user!.length == 10) {
      _userPhoneNumber = null;
      AppConstants.USER_MOBILE_NO = user;
      notifyListeners();
    } else {
      _userPhoneNumber = "Invalid mobile number";
      notifyListeners();
    }
  }

  //set phone no in shared


  var _setDataInSP;

  get setDataInSP => _setDataInSP;

  void setDataInSp(String? phoneNumber){
    MemoryManagement.setPhoneNumber(phoneNumber: phoneNumber!);
  }

  userSkipLogin(){
    saveDataToSharedPref("false","true");
  }

  // var _isSkip;
  //
  // get isSkip => _isSkip;

  // void setIsSkip(bool? isSkip){
  //   MemoryManagement.setIsSkipped(isSkipped: isSkip!);
  // }
  //
  //
  // void setUserInfo(Map? userInfo){
  //   MemoryManagement.setUserData(userInfoMap: userInfo!);
  //   notifyListeners();
  // }


  //otp and name validator

  TextEditingController userFullNameTextEditingController = TextEditingController();
  TextEditingController userOtpTextEditingController = TextEditingController();

  var _otpValidate;
  get otpLength => _otpValidate;

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

  String mobilenumber = "";
  // String username = "";
  String already_yn = "";
  String EncryptOTP = "N";
  String MyEncryptOTP = "";
  String login_app_web = "M";
  String ip_imei = AppConstants.DEVICE_ID!;
  bool isLoggedIn = false;


  //check phone number

  CheckMobileNumberResponse checkMobileNumberResponse = CheckMobileNumberResponse();
  CheckMobileNumberDataSource checkMobileNumberDataSource = CheckMobileNumberDataSource();

  Future<CheckMobileNumberResponse> checkMobileNumber(String mobileNumber) async{
    var response = await checkMobileNumberDataSource.checkMobileNumberApi(mobileNumber);
    print(response);
    checkMobileNumberResponse = CheckMobileNumberResponse.fromJson(response);
    if(checkMobileNumberResponse.code=="100"){
      already_yn = checkMobileNumberResponse.traveller![0].alreadyYn!;
      EncryptOTP = checkMobileNumberResponse.traveller![0].encryptOTP!;
      // username = checkMobileNumberResponse.traveller![0].username!;
      // if(checkMobileNumberResponse.traveller![0].username==null){
      //   username = "";
      // }else {
      //
      // }
    }


    // AppConstants.USER_MOBILE_NO = checkMobileNumberResponse.traveller![0].mobilenumber!;

    return checkMobileNumberResponse;

  }


  getOtp(BuildContext context, GlobalKey<FormState> formKey) async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
      if (formKey.currentState!.validate()) {
        //print(phoneNumberController.text.toString() + "aaaaaa");
        CommonMethods.showLoadingDialog(context);
        await checkMobileNumber(phoneNumberController.text.toString());
        if(checkMobileNumberResponse.code=="100"){
          otpLimitSet(otpLimit + 1);
          moveToOtpScreen(context);
        }else if (checkMobileNumberResponse.code=="999"){
          Navigator.pop(context);
          CommonMethods.showErrorDialog(context, "Something went wrong, please try again");
        }else {
          Navigator.pop(context);
        }
      }
    } else {
      CommonMethods.showNoInternetDialog(context);
    }
  }

  moveToOtpScreen(BuildContext context) {
    // print(username+"===>USER NAME");
    Navigator.pushNamed(context, MyRoutes.otpScreen, arguments: CheckMobileNumberArguments(
          checkMobileNumberResponse.traveller![0].mobilenumber!,
          checkMobileNumberResponse.traveller![0].username!,
          checkMobileNumberResponse.traveller![0].alreadyYn!,
          checkMobileNumberResponse.traveller![0].encryptOTP!,));
          phoneNumberController.clear();
  }


  saveDataToSharedPref(String isLoggedIn, String isSkipped) async{
    await MemoryManagement.setIsLoggedIn(isLoggedIn: isLoggedIn);
    await MemoryManagement.setUserName(userName: checkMobileNumberResponse.traveller![0].username!.toString());
    await MemoryManagement.setIsSkipped(isSkipped: isSkipped);
  }

}