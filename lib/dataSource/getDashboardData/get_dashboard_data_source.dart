import 'dart:async';

import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/getDashboardData/get_dashboard_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class GetDashboardDataSource implements GetDashboardApi{



  @override
  Future getDashboardApi(String mobileNo,String token) async {

    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("mobileNo", () => mobileNo);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    var response = await APIHandler.post(
        url: "${APIs.trvl_Dashboard}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);
    //print(requestBody);
    completer.complete(response);
    return completer.future;
  }

}