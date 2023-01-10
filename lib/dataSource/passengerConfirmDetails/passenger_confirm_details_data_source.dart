import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/passengerConfirmDetails/passenger_confirm_details_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class PassengerConfirmDetailsDataSource implements PassengerConfirmDetailsApi {

  @override
  Future passengerConfirmDetailsApi(String ticketNumber,String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    // requestBody.putIfAbsent("userId", () => ticketNumber);
    requestBody.putIfAbsent("ticketNo", () => ticketNumber);
    // requestBody.putIfAbsent("bookedByType", () => "T");
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.passengerConfirmDetails}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }

}
