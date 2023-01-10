import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/getPaymentsGatewaysDataSource/get_payments_gateways_Apis.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';
class GetPaymentGatewaysDataSource implements GetPaymentGatewaysApi {
  @override
  Future getPaymentGatewaysApi(String userId, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.getPaymentGateways}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }

}