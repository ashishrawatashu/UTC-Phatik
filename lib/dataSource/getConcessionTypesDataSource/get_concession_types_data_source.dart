import 'dart:async';

import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/getConcessionTypesDataSource/get_concession_types_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';



class GetConcessionTypesDataSource implements GetConcessionTypesApi {


  @override
  Future getConcessionTypes(String dsvcid, String fromstationId, String tostationId, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("dsvcid", () => dsvcid);
    requestBody.putIfAbsent("fromstationId", () => fromstationId);
    requestBody.putIfAbsent("tostationId", () => tostationId);
    requestBody.putIfAbsent("token", () => token);

    Completer<dynamic> completer = new Completer<dynamic>();
    var response = await APIHandler.post(
        url: "${APIs.getConcessionTypes}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);

    completer.complete(response);
    return completer.future;
  }
}
