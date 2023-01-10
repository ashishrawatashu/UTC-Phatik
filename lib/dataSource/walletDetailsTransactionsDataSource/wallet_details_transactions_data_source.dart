import 'dart:async';

import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/getWalletDetails/get_wallet_Api.dart';
import 'package:utc_flutter_app/dataSource/walletDetailsTransactionsDataSource/wallet_details_transactions_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class WalletDetailsTransactionsDataSource implements WalletDetailsTransactionsApi{

  @override
  Future walletDetailsTransactionsApi(String userId, String recordCount, String last_first_LF, String token) async {

    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("recordCount", () => recordCount);
    requestBody.putIfAbsent("last_first_LF", () => last_first_LF);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    var response = await APIHandler.post(
        url: "${APIs.wallet_Details_Transactions}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;

  }
}