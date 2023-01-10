import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/offersDataSource/offers_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class OffersSource implements OffersApi {

  @override
  Future offersApi(String mobileNo, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent(
        "Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("userId", () => mobileNo);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.offers}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}
