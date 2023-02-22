import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/isAppActiveDataSource/is_app_active_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class IsAppActiveDataSource implements IsAppActiveApi{

  @override
  Future isAppActiveApi(String token) async {

    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.isAppActive}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;

  }
}