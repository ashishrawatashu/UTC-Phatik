
import 'dart:async';
import 'package:dio/dio.dart';

import '../../utils/networkmodel/APIHandler.dart';
import '../../utils/networkmodel/APIs.dart';
import 'getCancelAvailableTickets_Api.dart';

class GetCancelAvailableTicketsDataSource implements GetCancelAvailableTicketsApi {

  @override
  Future getCancelAvailableTicketsApi(String userId, String ticketNo, String bookedByType, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("userID", () => userId);
    requestBody.putIfAbsent("ticketNo", () => ticketNo);
    requestBody.putIfAbsent("bookedByType", () => bookedByType);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.getCancelAvailableTickets}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);
    completer.complete(response);
    return completer.future;
  }
}