import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/loginFail/login_fail_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';


class LoginFailDataSource implements LoginFailApi {
  @override
  Future loginFailApi(
      String mobileNumber, String login_app_web, String ip_imei) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent(
        "Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("mobileNo", () => mobileNumber);
    requestBody.putIfAbsent("login_app_web", () => login_app_web);
    requestBody.putIfAbsent("ip_imei", () => ip_imei);
    Completer<dynamic> completer = new Completer<dynamic>();
    var response = await APIHandler.post(
        url: "${APIs.trvl_loginFail}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}
