import 'package:utc_flutter_app/dataSource/seatLayoutBoarding/seat_layout_boarding_Api.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/ticketsBusDataSource/tickets_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';
class TicketsDataSource implements TicketsApi {

  @override
  Future getTicketsApi(String userId,String transactionType,String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("transactionType", () => transactionType);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.getTickets}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}