import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/removeOfferDataSource/remove_offer_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class RemoveOfferDataSource implements RemoveOfferApi {
  @override
  Future removeOffer(
      String userId, String ticketNo, String offerId, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent(
        "Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("ticketNo", () => ticketNo);
    requestBody.putIfAbsent("offerId", () => offerId);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.removeOffer}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}
