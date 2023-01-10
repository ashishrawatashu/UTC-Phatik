
import 'dart:async';
import 'package:dio/dio.dart';

import '../../utils/networkmodel/APIHandler.dart';
import '../../utils/networkmodel/APIs.dart';
import 'get_confirm_tickets_APi.dart';

class GetConfirmTicketsDataSource implements GetConfirmTicketsApi {
  @override
  Future getConfirmTickets(String userId, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.getConfirmTickets }",
        requestBody: requestBody,
        additionalHeaders: requestHeader);
    completer.complete(response);
    return completer.future;
  }
}