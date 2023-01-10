import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/walletStatusDataSource/wallet_status_Api.dart';
import 'package:utc_flutter_app/dataSource/walletTicketConfirmDataSource/wallet_ticket_confirm_Api.dart';
import 'package:utc_flutter_app/dataSource/walletTopUpDataSource/wallet_top_up_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';
class WalletTicketConfirmDataSource implements WalletTicketConfirmApi {
  @override
  Future walletTicketConfirmApi(String userId, String ticketNo, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("ticketNo", () => ticketNo);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.wallet_Ticket_Confirm}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}