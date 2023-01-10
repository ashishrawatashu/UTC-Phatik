import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/walletStatusDataSource/wallet_status_Api.dart';
import 'package:utc_flutter_app/dataSource/walletTopUpDataSource/wallet_top_up_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';
class WalletTopUpStatusDataSource implements WalletTopUpStatusApi {

  @override
  Future walletTopUpStatusApi(String txnRefrence, String userId) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("txnRefrence", () => txnRefrence);
    requestBody.putIfAbsent("userId", () => userId);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.walletTopupStatus}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }

}