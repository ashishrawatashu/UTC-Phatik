import 'dart:async';

import 'package:dio/dio.dart';

import '../../utils/networkmodel/APIHandler.dart';
import '../../utils/networkmodel/APIs.dart';
import 'get_destination_Api.dart';



class GetDestinationDataSource implements GetDestinationApi {
  @override
  Future getAllDestinationApi(String searchKeyword,String flag_F_T, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("stationText", () => searchKeyword);
    requestBody.putIfAbsent("flag_F_T", () => flag_F_T);
    requestBody.putIfAbsent("otherValue", () => "");
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);

    var response = await APIHandler.post(
        url: "${APIs.search_station_app}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);
    completer.complete(response);

    return completer.future;
  }
}
