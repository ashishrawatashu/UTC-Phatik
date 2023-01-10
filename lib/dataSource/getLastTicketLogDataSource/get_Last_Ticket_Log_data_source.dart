import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/getLastTicketLogDataSource/get_Last_Ticket_Log_Api.dart';
import 'package:utc_flutter_app/dataSource/walletStatusDataSource/wallet_status_Api.dart';
import 'package:utc_flutter_app/dataSource/walletTopUpDataSource/wallet_top_up_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';
class GetLastTicketLogDataSource implements GetLastTicketLogApi {

  @override
  Future getLastTicketLogApi(String userId, String ticketNo) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("ticketNo", () => ticketNo);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.getLastTicketLog}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }

}