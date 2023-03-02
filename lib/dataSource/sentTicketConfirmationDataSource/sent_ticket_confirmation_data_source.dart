import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/removeOfferDataSource/remove_offer_Api.dart';
import 'package:utc_flutter_app/dataSource/saveAlarmDataSource/save_alarm_Api.dart';
import 'package:utc_flutter_app/dataSource/sentTicketConfirmationDataSource/sent_ticket_confirmation_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class SentTicketConfirmationDataSource implements SentTicketConfirmationApi {

  @override
  Future sentTicketConfirmationApi(String ticketNo, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("ticketNo", () => ticketNo);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.send_ticket_confirmation}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }

}
