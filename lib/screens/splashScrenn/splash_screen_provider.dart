import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:utc_flutter_app/constants/strings.dart';
import 'package:utc_flutter_app/dataSource/isAppActiveDataSource/is_app_active_data_source.dart';
import 'package:utc_flutter_app/response/is_app_active.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

class SplashScreenProvider extends ChangeNotifier{

 EncryptedSharedPreferences encryptedSharedPreferences = EncryptedSharedPreferences();
  String isUserLoggedIn = "";
  String isUserSkipped = "";

  getDataOfSharedPref() async {
    await getIsLoggedIn();
    await getIsSkipped();
  }

  getIsLoggedIn() async{
    await  encryptedSharedPreferences.getString(StringsFile.isLoggedIn).then((String value) {
      isUserLoggedIn = value;/// Prints Hello, World!
    });
  }

  getIsSkipped() {
    encryptedSharedPreferences.getString(StringsFile.isSkipped).then((String value) {
      isUserSkipped = value;/// Prints Hello, World!
    });
  }


 IsAppActiveDataSource isAppActiveDataSource = IsAppActiveDataSource();
 IsAppActive isAppActive = IsAppActive();
 Future<IsAppActive> isAppActiveOrNot() async {
   var response = await isAppActiveDataSource.isAppActiveApi(AppConstants.IS_APP_ACTIVE_TOKEN);

   //print(response);
   isAppActive = IsAppActive.fromJson(response);
   return isAppActive;

 }

 getUserData(BuildContext context) async {
   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
   if (Platform.isIOS) {
     //print("ios");
     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
     //print('Running on ${iosInfo.identifierForVendor}');
     AppConstants.DEVICE_ID = iosInfo.identifierForVendor;
   } else {
     //print("android");
     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
     //print('Running on ${androidInfo.androidId}');
     AppConstants.DEVICE_ID = androidInfo.androidId;
   }
   //print(AppConstants.DEVICE_ID);
   await getIsLoggedIn();
   await getIsSkipped();
   //print(isUserLoggedIn);

   if (await CommonMethods.getInternetUsingInternetConnectivity()) {
     PackageInfo packageInfo = await PackageInfo.fromPlatform();
     String appName = packageInfo.appName;
     String packageName = packageInfo.packageName;
     String version = packageInfo.version;
     String buildNumber = packageInfo.buildNumber;
     //print(packageName+"===>"+version+"===>"+appName+"===>"+buildNumber);
     await isAppActiveOrNot();
     if(isAppActive.code=="100"){
       if(isAppActive.result!.isEmpty){
         CommonMethods.showErrorDialog(context,"Something went wrong, please try again");
       }else {
         if(isAppActive.result![0].active=="Y"&&isAppActive.result![0].version==buildNumber){
           AppConstants.HELP_DESK_EMAIL = isAppActive.helpdek![0].emailId.toString();
           AppConstants.HELP_DESK_PHONE = isAppActive.helpdek![0].mobileNo.toString();
           Future.delayed(const Duration(seconds: 3), () {
             if(isUserLoggedIn=="true"||isUserSkipped=="true"){
               Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
             }else {
               Navigator.pushReplacementNamed(context, MyRoutes.getPhoneNumberScreen);
             }
           });
         }else if(isAppActive.result![0].active=="Y"&&isAppActive.result![0].version!=buildNumber){
           CommonMethods.updateApp(context,"UTC Phatik new version is available.");
         }else {
           CommonMethods.showIsAppNotActive(context,isAppActive.helpdek![0].mobileNo.toString(),isAppActive.helpdek![0].emailId.toString());
         }
       }
     }else if (isAppActive.code=="999"){
       CommonMethods.showErrorDialog(context,"Something went wrong, please try again");
     }else if (isAppActive.code=="101"){
       Navigator.pushReplacementNamed(context, MyRoutes.errorMsg);
     }else{
       CommonMethods.showErrorDialog(context,"Something went wrong, please try again");
     }
   } else {
     CommonMethods.showNoInternetDialog(context);
   }
 }

}