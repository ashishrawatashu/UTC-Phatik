import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:utc_flutter_app/dataSource/checkMobileNumber/check_mobile_number_data_source.dart';
import 'package:utc_flutter_app/dataSource/loginFail/login_fail_data_source.dart';
import 'package:utc_flutter_app/dataSource/loginFirstTime/login_first_time_data_source.dart';
import 'package:utc_flutter_app/dataSource/loginSuccess/login_success_data_source.dart';
import 'package:utc_flutter_app/response/check_mobile_number_response.dart';
import 'package:utc_flutter_app/response/login_first_time_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'constants/strings.dart';
import 'utils/sharedpref/memory_management.dart';

class CommonProviderForInAppLogin extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();
  var formKeyForLoginDialog = GlobalKey<FormState>();
  String mobilenumber = "";
  String username = "";
  String already_yn = "";
  String EncryptOTP = "N";
  String MyEncryptOTP = "";
  String login_app_web = "M";
  String ip_imei = AppConstants.DEVICE_ID!;
  bool isLoggedIn = false;
  EncryptedSharedPreferences encryptedSharedPreferences =
  EncryptedSharedPreferences();
  TextEditingController userPhoneTextEditingController = TextEditingController(text: AppConstants.USER_MOBILE_NO);
  TextEditingController userFullNameTextEditingController = TextEditingController();
  TextEditingController userOtpTextEditingController = TextEditingController();

  var _otpLimit = 0;
  get otpLimit => _otpLimit;


  bool fromResend = false;
  otpLimitSet(var limit){
    _otpLimit = limit;
    // print(otpLimit);
    notifyListeners();
  }

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


  clearAllData(){
    userPhoneTextEditingController.clear();
    userOtpTextEditingController.clear();
    userFullNameTextEditingController.clear();
  }


  matchOtp() async {
    if(EncryptOTP==MyEncryptOTP){
      // print("OTP valid");
      if(already_yn=="N"){
        print("For N");
        await loginFirstTime(userPhoneTextEditingController.text.toString(), userFullNameTextEditingController.text.toString(), login_app_web,ip_imei);
        saveDataToSharedPref("true","false");
      }else {
        // print("For Yyyyy");
        await loginSuccess(userPhoneTextEditingController.text.toString(), login_app_web, ip_imei);
        saveDataToSharedPref("true","false");
        // if(loginSuccessResponse.code=="100"){
        //
        // }else if (loginSuccessResponse.code=="101") {
        //
        // }else {
        //
        // }
      }
      return true;
    }else{
      // print("OTP invalid");
      await loginFail(mobilenumber, login_app_web, ip_imei);
      if(loginSuccessResponse.code=="100"){

      }else if (loginSuccessResponse.code=="101") {

      }else {

      }
      return false;
    }

  }


  saveDataToSharedPref(String isLoggedIn, String isSkipped) async{
    await MemoryManagement.setIsLoggedIn(isLoggedIn: isLoggedIn);
    await MemoryManagement.setUserName(userName: username);
    await MemoryManagement.setIsSkipped(isSkipped: isSkipped);

  }

  //first Time user login APi integration

  LoginResponse loginFirstTimeResponse = LoginResponse();
  LoginFirstTimeDataSource loginFirstTimeDataSource = LoginFirstTimeDataSource();

  Future<LoginResponse> loginFirstTime(String mobileNumber,String userName,String login_app_web, String ip_imei) async{
    var response = await loginFirstTimeDataSource.loginFirstTimeApi(mobileNumber,userName,login_app_web,ip_imei);
    // print(response);
    loginFirstTimeResponse = LoginResponse.fromJson(response);
    username = userFullNameTextEditingController.text.toString();
    MemoryManagement.setPhoneNumber(phoneNumber: userPhoneTextEditingController.text.toString());
    MemoryManagement.setUserName(userName: username);
    await getPhoneNumber();
    clearAllData();
    return loginFirstTimeResponse;

  }


  // login Success Api integration

  LoginResponse loginSuccessResponse = LoginResponse();
  LoginSuccessDataSource loginSuccessDataSource = LoginSuccessDataSource();

  Future<LoginResponse> loginSuccess(String mobileNumber,String login_app_web, String ip_imei) async{
    var response = await loginSuccessDataSource.loginSuccessApi(mobileNumber,login_app_web,ip_imei);
    // print(response);
    loginSuccessResponse = LoginResponse.fromJson(response);
    if(loginSuccessResponse.code=="100"){
      // print(userPhoneTextEditingController.text.toString()+"PHONEEEEE");
      MemoryManagement.setPhoneNumber(phoneNumber: mobileNumber);
      MemoryManagement.setUserName(userName: username);
      await getPhoneNumber();
      clearAllData();
    }

    return loginSuccessResponse;

  }

  //login fail Api integration

  LoginResponse loginFailTimeResponse = LoginResponse();
  LoginFailDataSource loginFailDataSource = LoginFailDataSource();

  Future<LoginResponse> loginFail(String mobileNumber,String login_app_web, String ip_imei) async{
    var response = await loginFailDataSource.loginFailApi(mobileNumber,login_app_web,ip_imei);
    // print(response);
    loginFailTimeResponse = LoginResponse.fromJson(response);
    return loginFailTimeResponse;

  }

  //check phone number

  CheckMobileNumberResponse checkMobileNumberResponse = CheckMobileNumberResponse();
  CheckMobileNumberDataSource checkMobileNumberDataSource = CheckMobileNumberDataSource();

  Future<CheckMobileNumberResponse> checkMobileNumber(String mobileNumber) async{
    var response = await checkMobileNumberDataSource.checkMobileNumberApi(mobileNumber);
    // print(response);
    checkMobileNumberResponse = CheckMobileNumberResponse.fromJson(response);
    if(checkMobileNumberResponse.code=="100") {
      already_yn = checkMobileNumberResponse.traveller![0].alreadyYn!;
      EncryptOTP = checkMobileNumberResponse.traveller![0].encryptOTP!;
      if(checkMobileNumberResponse.traveller![0].username==null){
        username = "";
      }else {
        username = checkMobileNumberResponse.traveller![0].username!;
      }
    }
    return checkMobileNumberResponse;

  }

  getPhoneNumber() async {
    await encryptedSharedPreferences
        .getString(StringsFile.phoneNumber)
        .then((String value) {
      print(value + "PHONE NUMBER GET");
      AppConstants.USER_MOBILE_NO = value;
      // print(AppConstants.USER_MOBILE_NO);
      /// Prints Hello, World!
    });

    await encryptedSharedPreferences
        .getString(StringsFile.userName)
        .then((String value) {
      // print(value + "USERNAME GET ");
      AppConstants.USER_NAME = value;

      /// Prints Hello, World!
    });
  }
}