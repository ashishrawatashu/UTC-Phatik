import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/getTicketDetailsDataSource/get_ticket_details_Api.dart';
import 'package:utc_flutter_app/dataSource/passengerConfirmDetails/passenger_confirm_details_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class GetTicketsDetailsDataSource implements GetTicketDetailsApi {

  @override
  Future getTicketDetailsApi(String ticketNumber,String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("ticketNo", () => ticketNumber);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.getTicketDetails}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }

}
