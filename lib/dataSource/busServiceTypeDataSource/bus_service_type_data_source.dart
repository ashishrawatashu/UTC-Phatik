import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/busServiceTypeDataSource/bus_service_type_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';
class BusServiceTypeDataSource implements BusServiceTypeApi {
  @override
  Future busServiceTypeApi(String srtpId, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("srtpId", () => srtpId);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.bus_serviceType}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);
    completer.complete(response);
    return completer.future;
  }
}