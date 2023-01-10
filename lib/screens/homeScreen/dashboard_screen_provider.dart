import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:utc_flutter_app/constants/strings.dart';
import 'package:utc_flutter_app/dataSource/notificationDataSource/notif_offer_data_source.dart';
import 'package:utc_flutter_app/dataSource/notificationDataSource/notif_service_data_source.dart';
import 'package:utc_flutter_app/response/notification_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import '../../utils/notifications_class.dart';

class DashBoardScreenProvider extends ChangeNotifier {
  EncryptedSharedPreferences encryptedSharedPreferences =
      EncryptedSharedPreferences();
  String isUserLoggedIn = "";
  String isUserSkipped = "";
  NotificationApis notificationApis = NotificationApis();

  getDataOfSharedPref() async {
    await getIsLoggedIn();
    await getIsSkipped();
  }

  getIsLoggedIn() async {
    await encryptedSharedPreferences
        .getString(StringsFile.isLoggedIn)
        .then((String value) {
      isUserLoggedIn = value;

      /// Prints Hello, World!
    });
  }

  getIsSkipped() {
    encryptedSharedPreferences
        .getString(StringsFile.isSkipped)
        .then((String value) {
      isUserSkipped = value;

      /// Prints Hello, World!
    });
  }

  getNotification() async {
    notificationApis.intialize();
    if (AppConstants.NOTIFICATIONS == false) {
      getOfferNotification();
      getServiceNotification();
    }
  }

  NotificationResponse notificationResponse = NotificationResponse();
  NotificationServiceDataSource notificationServiceDataSource =
      NotificationServiceDataSource();

  Future<NotificationResponse> getServiceNotification() async {
    var response = await notificationServiceDataSource.getNotificationApi();
    //print(response);
    notificationResponse = NotificationResponse.fromJson(response);
    if (notificationResponse.code == "100") {
      notificationApis.showScheduleNotifications(1, notificationResponse.tittle.toString(), notificationResponse.text.toString(), 10);
      AppConstants.NOTIFICATIONS = true;
    }
    return notificationResponse;
  }

  NotificationResponse notificationOfferResponse = NotificationResponse();
  NotificationOfferDataSource notificationOfferDataSource = NotificationOfferDataSource();

  Future<NotificationResponse> getOfferNotification() async {
    var response = await notificationOfferDataSource.getNotificationApi();
    //print(response);
    notificationOfferResponse = NotificationResponse.fromJson(response);
    if (notificationOfferResponse.code == "100") {
      notificationApis.showScheduleNotifications(
          2,
          notificationOfferResponse.tittle.toString(),
          notificationOfferResponse.text.toString(),
          10);
    }
    return notificationOfferResponse;
  }

  getUserData() async {
    await getIsLoggedIn();
    await getIsSkipped();
  }



}
