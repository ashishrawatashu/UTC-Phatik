import 'dart:async';

import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/authenticationMethodDataSource/authentication_method_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class AuthenticationMethodDataSource implements AuthenticationMethodApi {

  @override
  Future authenticationMethod(String userId, String IMEI) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("IMEI", () => IMEI);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.AuthenticationMethod}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);
    completer.complete(response);
    return completer.future;
  }
}