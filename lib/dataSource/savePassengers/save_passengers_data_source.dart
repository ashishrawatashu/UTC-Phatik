import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/savePassengers/save_passengers_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class SavePassengersDataSource implements SavePassegersApi {


  @override
  Future savePassengersApi(String depotServiceCode, String tripType, String strpid, String journeyDate, String fromStationId, String toStationId,String bookingTypeCode, String userId, String userMobile, String userEmail, String bordeingStationId, String passengers, String ip_imei,String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("depotServiceCode", () => depotServiceCode);
    requestBody.putIfAbsent("tripType", () => tripType);
    requestBody.putIfAbsent("strpid", () => strpid);
    requestBody.putIfAbsent("journeyDate", () => journeyDate);
    requestBody.putIfAbsent("fromStationId", () => fromStationId);
    requestBody.putIfAbsent("toStationId", () => toStationId);
    requestBody.putIfAbsent("booked_by_type_code", () => bookingTypeCode);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("userMobile", () => userMobile);
    requestBody.putIfAbsent("userEmail", () => userEmail);
    requestBody.putIfAbsent("bordeingStationId", () => bordeingStationId);
    requestBody.putIfAbsent("passengers", () => passengers);
    requestBody.putIfAbsent("ip_imei", () => ip_imei);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.savePassengers}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}
