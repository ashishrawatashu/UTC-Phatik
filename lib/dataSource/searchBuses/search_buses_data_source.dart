import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/searchBuses/search_buses_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class SearchBusesDataSource implements SearchBusesApi {
  @override
  Future getSearchBusesApi(
      String fromStationName, String toStationName, String serviceTypeId, String date, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("fromStationName", () => fromStationName);
    requestBody.putIfAbsent("toStationName", () => toStationName);
    requestBody.putIfAbsent("serviceTypeId", () => serviceTypeId);
    requestBody.putIfAbsent("journeyDate", () => date);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.search_services}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}
