import 'dart:async';

import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/getWalletDetails/get_wallet_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class GetWalletDataSource implements GetWalletApi{

  @override
  Future getWalletApi(String userId,String token) async {

    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    var response = await APIHandler.post(
        url: "${APIs.getWallet}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;

  }
}