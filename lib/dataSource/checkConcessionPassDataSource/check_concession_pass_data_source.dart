import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/checkConcessionDataSource/check_concession_Api.dart';
import 'package:utc_flutter_app/dataSource/checkConcessionPassDataSource/check_concession_pass_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';



class CheckConcessionPassDataSource implements CheckConcessionPassApi {

  @override
  Future checkConcessionPassApi(String concession, String passno, String journeyDate, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("concession", () => concession);
    requestBody.putIfAbsent("passno", () => passno);
    requestBody.putIfAbsent("journeyDate", () => journeyDate);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.checkConcessionPass}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}
