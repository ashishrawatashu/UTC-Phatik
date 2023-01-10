import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/getQRTextEnDataSource/get_qr_text_en_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class GetQRTextEnDataSource implements GetQRTextEnApi {
  @override
  Future getQRTextEnApi(String ticketNo, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent(
        "Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("ticketNo", () => ticketNo);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.getQRTextEn}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}
