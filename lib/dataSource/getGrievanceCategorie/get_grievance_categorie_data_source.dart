import 'package:utc_flutter_app/dataSource/getGrievanceCategorie/get_grievance_categorie_Api.dart';
import 'package:utc_flutter_app/dataSource/seatLayoutBoarding/seat_layout_boarding_Api.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';
class GetGrievanceCategoryDataSource implements GetGrievanceCategoryApi {

  @override
  Future getGrievanceCategoryApi(String userId, String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, String> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);
    var response = await APIHandler.post(
        url: "${APIs.getGrievanceCategories}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);
    completer.complete(response);
    return completer.future;
  }
}