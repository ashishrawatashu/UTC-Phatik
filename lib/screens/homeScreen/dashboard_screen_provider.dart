import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:utc_flutter_app/constants/strings.dart';
import 'package:utc_flutter_app/dataSource/notificationDataSource/notif_offer_data_source.dart';
import 'package:utc_flutter_app/dataSource/notificationDataSource/notif_service_data_source.dart';
import 'package:utc_flutter_app/response/notification_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import '../../utils/notifications_class.dart';

class DashBoardScreenProvider extends ChangeNotifier {
  EncryptedSharedPreferences encryptedSharedPreferences = EncryptedSharedPreferences();
  String isUserLoggedIn = "";
  String isUserSkipped = "";

  getDataOfSharedPref() async {
    await getIsLoggedIn();
    await getIsSkipped();
  }

  getIsLoggedIn() async {
    await encryptedSharedPreferences
        .getString(StringsFile.isLoggedIn)
        .then((String value) {
      isUserLoggedIn = value;

    });
  }

  getIsSkipped() {
    encryptedSharedPreferences
        .getString(StringsFile.isSkipped)
        .then((String value) {
      isUserSkipped = value;
    });
  }

  getUserData() async {
    await getIsLoggedIn();
    await getIsSkipped();
  }



}
