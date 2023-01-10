import 'dart:convert';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utc_flutter_app/constants/strings.dart';
import 'package:utc_flutter_app/response/recent_searches_data.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';

class MemoryManagement {

  static late SharedPreferences prefs;
  static EncryptedSharedPreferences encryptedSharedPreferences = EncryptedSharedPreferences();

  static Future<bool?> init() async {
    prefs = await SharedPreferences.getInstance();
    // encryptedSharedPreferences =  EncryptedSharedPreferences as EncryptedSharedPreferences;

    return true;

  }

  static void setRecentData({required String resendData}) async {
   await prefs.setString(StringsFile.recentSearch, resendData);
  }

  static String? getRecentData(){

    return prefs.getString(StringsFile.recentSearch);
  }

  static setPhoneNumber({ required String phoneNumber}) async{
    await encryptedSharedPreferences.setString(StringsFile.phoneNumber, phoneNumber).then((bool success){
      if (success) {
        print("PHONE save");
        AppConstants.USER_MOBILE_NO = phoneNumber;
      } else {
        print('PHONE fail');
      }
    });
  }

  static setLoginDateTime({ required String dateTime}) async{
    await encryptedSharedPreferences.setString(StringsFile.loginDateTime, dateTime.toString()).then((bool success){
      if (success) {
        //print("dateTime save");
      } else {
        //print('dateTime fail');
      }
    });
  }

  static setUserName({ required String userName}) async {
    await encryptedSharedPreferences.setString(StringsFile.userName, userName).then((bool success){
      if (success) {
        print("USER save");
        AppConstants.USER_NAME = userName;
      } else {
        print('USER fail');
      }
    });
  }

  static  setIsLoggedIn({ required String isLoggedIn}) async{
    await encryptedSharedPreferences.setString(StringsFile.isLoggedIn, isLoggedIn).then((bool success) {
      if (success) {
       //print("IS LOG save");
      } else {
        //print('IS LOGfail');
      }
    });
  }

  static setIsSkipped({ required String isSkipped}) async{
    await encryptedSharedPreferences.setString(StringsFile.isSkipped, isSkipped).then((bool success) {
      if (success) {
        //print("IS SKIP save");
      } else {
        //print(' IS SKIP fail');
      }
    });
  }

  static clearAllDataInSharedPref() async {
    await encryptedSharedPreferences.clear().then((bool success) {
      if (success) {
        //print('IS CLEAR success');
      } else {
        //print('IS CLEAR fail');
      }
    });
  }


}
