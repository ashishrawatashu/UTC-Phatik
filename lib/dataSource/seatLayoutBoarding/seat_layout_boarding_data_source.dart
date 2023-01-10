import 'package:utc_flutter_app/dataSource/seatLayoutBoarding/seat_layout_boarding_Api.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';
class SeatLayoutBoardingDataSource implements SeatLayoutBoardingApi {
  @override
  Future getSeatLayoutBoardingApi(String dsvcId, String journeyDate, String strpId, String toStationId,String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("dsvcId", () => dsvcId);
    requestBody.putIfAbsent("journeyDate", () => journeyDate);
    requestBody.putIfAbsent("strpId", () => strpId);
    requestBody.putIfAbsent("toStationId", () => toStationId);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.layout_boarding}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}