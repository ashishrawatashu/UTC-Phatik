import 'dart:async';

import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/saveRatingDataSource/save_rating_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class SaveRatingDataSource implements SaveRatingApi{
  @override
  Future saveRatingApi(String ticketNo, String userId, String portalRating, String staffRating, String busRating, String portalFeedback, String staffFeedback, String busFeedback, String ip_imei,String token) async{
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("tktNo", () => ticketNo);
    requestBody.putIfAbsent("bookingRate", () => portalRating);
    requestBody.putIfAbsent("conductorRate", () => staffRating);
    requestBody.putIfAbsent("busRate", () => busRating);
    requestBody.putIfAbsent("bookingFeedback", () => portalFeedback);
    requestBody.putIfAbsent("conductorFeedback", () => staffFeedback);
    requestBody.putIfAbsent("busFeedback", () => busFeedback);
    requestBody.putIfAbsent("IMEI", () => ip_imei);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.saveRating}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);
    completer.complete(response);
    return completer.future;
  }

}