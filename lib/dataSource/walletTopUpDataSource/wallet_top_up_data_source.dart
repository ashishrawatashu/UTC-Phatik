import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/walletTopUpDataSource/wallet_top_up_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';
class WalletTopUpDataSource implements WalletTopUpApi {

  @override
  Future walletTopUpeApi(String txnRefrence, String userId, String amount, String txn_first_last)async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("txnRefrence", () => txnRefrence);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("amount", () => amount);
    requestBody.putIfAbsent("txn_first_last", () => txn_first_last);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.walletTopupStartCompleted}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}