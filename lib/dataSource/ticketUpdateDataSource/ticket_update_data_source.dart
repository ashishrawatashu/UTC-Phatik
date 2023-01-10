import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/ticketUpdateDataSource/ticket_update_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';
class TicketUpdateDataSource implements TicketsUpdateApi {

  @override
  Future getTicketUpdateApi(String ticketNumber, String paymentMode) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("ticketNumber", () => ticketNumber);
    requestBody.putIfAbsent("paymentMode", () => paymentMode);

    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.ticketUpdate}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}