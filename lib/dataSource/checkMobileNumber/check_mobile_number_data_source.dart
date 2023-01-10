import 'dart:async';
import 'package:dio/dio.dart';

import '../../utils/networkmodel/APIHandler.dart';
import '../../utils/networkmodel/APIs.dart';
import 'check_mobile_number_Api.dart';

class CheckMobileNumberDataSource implements CheckMobileNumberApi {
  @override
  Future checkMobileNumberApi(String mobileNumber) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("mobileNo", () => mobileNumber);
    //print(requestBody);
    Completer<dynamic> completer = new Completer<dynamic>();
    var response = await APIHandler.post(
        url: "${APIs.trvl_checkMobileNo}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}
