import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/checkConcessionDataSource/check_concession_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';



class CheckConcessionDataSource implements CheckConcessionApi {


  @override
  Future checkConcessionApi(String concession, String gender, String age, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("concession", () => concession);
    requestBody.putIfAbsent("gender", () => gender);
    requestBody.putIfAbsent("age", () => age);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.checkConcession}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);
    completer.complete(response);
    return completer.future;
  }
}
