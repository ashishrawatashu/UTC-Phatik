import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/cancelTickets/cancel_tickets_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';



class CancelTicketDataSource implements CancelTicketsApi {

  @override
  Future cancelTickets(String userId, String ticketNo, String seatNos, String seatCounts, String cancellededByType, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("ticketNo", () => ticketNo);
    requestBody.putIfAbsent("seatNos", () => seatNos);
    requestBody.putIfAbsent("seatCounts", () => seatCounts);
    requestBody.putIfAbsent("cancellededByType", () => cancellededByType);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    ////print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.saveCancelTicket}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}
