import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart'as tz;
import 'package:timezone/data/latest.dart'as tz;
class NotificationApis {
  NotificationApis();

  final _localNotifications = FlutterLocalNotificationsPlugin();
  Future<void> intialize() async {
    tz.initializeTimeZones();
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/app_icon');

     IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings
    );


    await _localNotifications.initialize(initializationSettings,onSelectNotification: onSelectNotification);
  }

  Future<NotificationDetails> notificationsDetails () async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channelId', 'channelName',channelDescription: 'description',
        importance: Importance.max);


    IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();

    return NotificationDetails(android: androidNotificationDetails,iOS: iosNotificationDetails);

  }


  Future<void> showNotifications(int id, String title, String body) async {
    final details = await notificationsDetails();
    await _localNotifications.show(id, title, body, details);

  }

  Future<void> showScheduleNotifications(int id, String title, String body,int sec) async {
    final details = await notificationsDetails();
    await _localNotifications.zonedSchedule(id, title, body,tz.TZDateTime.from(DateTime.now().add(Duration(seconds: sec)), tz.local), details,
    androidAllowWhileIdle: true,uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);

  }
  void onSelectNotification(String? payload) {

  }

  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
  }
}
