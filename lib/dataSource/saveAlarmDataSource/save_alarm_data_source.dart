import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/removeOfferDataSource/remove_offer_Api.dart';
import 'package:utc_flutter_app/dataSource/saveAlarmDataSource/save_alarm_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class SaveAlarmDataSource implements SaveAlarmApi {

  @override
  Future saveAlarmApi(String alarmTypeId, String reportedBy, String latt, String longg, String ticketNo, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("alarmTypeId", () => alarmTypeId);
    requestBody.putIfAbsent("reportedBy", () => reportedBy);
    requestBody.putIfAbsent("latt", () => latt);
    requestBody.putIfAbsent("longg", () => longg);
    requestBody.putIfAbsent("ticketNo", () => ticketNo);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.saveAlarm}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }

}
