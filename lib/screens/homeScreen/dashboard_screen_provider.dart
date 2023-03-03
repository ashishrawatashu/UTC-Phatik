import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:utc_flutter_app/constants/strings.dart';

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
