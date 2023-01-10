import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/applyOfferDataSource/apply_offer_Api.dart';

import '../../utils/networkmodel/APIHandler.dart';
import '../../utils/networkmodel/APIs.dart';

class ApplyOfferDataSource implements ApplyOfferApi {
  @override
  Future applyOffer(String userId, String ticketNo, String offerId, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("ticketNo", () => ticketNo);
    requestBody.putIfAbsent("offerId", () => offerId);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.applyOffer}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}
