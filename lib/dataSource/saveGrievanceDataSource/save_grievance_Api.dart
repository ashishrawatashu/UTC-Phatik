import 'package:flutter/services.dart';

abstract class SaveGrievanceApi{
  Future<dynamic> saveGrievanceApi(
      String category,
      String subcategory,
      String busno,
      String ticketno,
      String description,
      String pic1,
      String pic2,
      String latt,
      String longg,
      String userId,
      String ip_imei,
      String token);

}