import 'dart:async';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:utc_flutter_app/dataSource/passengerConfirmDetails/passenger_confirm_details_Api.dart';
import 'package:utc_flutter_app/dataSource/saveGrievanceDataSource/save_grievance_Api.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIHandler.dart';
import 'package:utc_flutter_app/utils/networkmodel/APIs.dart';

class SaveGrievanceDataSource implements SaveGrievanceApi {
  @override
  Future saveGrievanceApi(String category, String subcategory, String busno, String ticketno, String description, String pic1, String pic2, String latt, String longg, String userId, String ip_imei,String token) async {
    Map<String, String> requestHeader = Map();
    Map<String, dynamic> requestBody = Map();
    requestHeader.putIfAbsent("Content-Type", () => Headers.formUrlEncodedContentType);
    requestBody.putIfAbsent("category", () => category);
    requestBody.putIfAbsent("subcategory", () => subcategory);
    requestBody.putIfAbsent("busno", () => busno);
    requestBody.putIfAbsent("ticketno", () => ticketno);
    requestBody.putIfAbsent("description", () => description);
    requestBody.putIfAbsent("pic1", () => pic1);
    requestBody.putIfAbsent("pic2", () => pic2);
    requestBody.putIfAbsent("latt", () => latt);
    requestBody.putIfAbsent("longg", () => longg);
    requestBody.putIfAbsent("userId", () => userId);
    requestBody.putIfAbsent("ip_imei", () => ip_imei);
    requestBody.putIfAbsent("token", () => token);
    Completer<dynamic> completer = new Completer<dynamic>();
    //print(requestBody);

    var response = await APIHandler.post(
        url: "${APIs.saveGrievance}",
        requestBody: requestBody,
        additionalHeaders: requestHeader);
    completer.complete(response);
    return completer.future;
  }

}
